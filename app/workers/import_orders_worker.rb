class ImportOrdersWorker
  include Sidekiq::Worker

  def perform
    # Ensure the file exists

    file_path = Rails.root.join('lib', 'data', 'noah_dev_orders.json')

    # Ensure the file exists
    unless File.exist?(file_path)
      Rails.logger.error "File not found: #{file_path}"
      return
    end

    # Read and parse the JSON file
    json_data = File.read(file_path)
    orders_data = JSON.parse(json_data)

    # Process each order
    orders_data.group_by { |order| order['Name'] }.each do |order_number, order_items|
      process_order(order_number, order_items)
    end
  end

  private

  def process_order(order_number, order_items)
    # Initialize or find the existing order
    order_data = order_items.first
    order = Order.find_or_initialize_by(order_number: order_number)

    # Determine order status
    status = determine_status(order_data)
    partner = find_partner(order_data)
    if partner
       # Assign attributes to the order
      order.assign_attributes(
        shopify_order_id: order_data["Id"],
        status: status,
        order_date: order_data['Created at'],
        order_value: order_data['Total'].to_f,
        currency: order_data['Currency'],
        payment_status: order_data['Financial Status'],
        first_name: order_data['Billing Name'],
        last_name: '', # Assuming 'last_name' is not provided separately
        email: order_data['Email'],
        company: order_data['Billing Company'],
        address_1: order_data['Billing Address1'],
        address_2: order_data['Billing Address2'],
        zip_code: order_data['Billing Zip'],
        city: order_data['Billing City'],
        country: order_data['Billing Country'],
        fulfillment_status: order_data['Fulfillment Status'],
        tracking_number: order_data['Tracking Number'] || '',
        student_id: student_id(order_data),
        arrival_date: arrival_date(order_data),
        products: products(order_data),
        partner_id: 1,
        residence_id: find_residence(order_data)&.id
      )

      # Save or update the order
      order.save!

      # Clear existing items and add new ones
      order.items.destroy_all

      order_items.each do |item|
        next if item['Lineitem name'].blank? # Skip if no product name

        order.items.build(
          product_name: item['Lineitem name'],
          sku: item['Lineitem sku'],
          quantity: item['Lineitem quantity'].to_i,
          price: item['Lineitem price'].to_f,
          line_item_id: item['Id']
        )
      end

      order.save!

      process_refunds(order, order_data)
    end

  end

  def determine_status(order_data)

    if order_data['Cancelled at'].present?
      "cancelled"
    elsif order_data['Fulfillment Status'].present?
      "fulfilled"
    else
      "created"
    end
  end

  def find_partner(order_data)
    partner_parameter = order_data['Note Attributes'].match(/Partner Parameter: (.+)/)&.captures&.first
    discount_code = order_data['Discount Code']

    Partner.find_by(parameter: partner_parameter) || Partner.find_by(discount_code: discount_code)
  end

  def find_residence(order_data)
    residence_parameter = order_data['Note Attributes'].match(/Residence: (.+)/)&.captures&.first
    Residence.find_by(name: residence_parameter)
  end

  def student_id(order_data)
    order_data['Note Attributes'].match(/Student Id: (.+)/)&.captures&.first
  end

  def arrival_date(order_data)
    order_data['Note Attributes'].match(/Arrival Date: (.+)/)&.captures&.first
  end

  def products(order_data)
    order_data['Lineitem name'] ? "#{order_data['Lineitem quantity']}x #{order_data['Lineitem name']} | #{order_data['Lineitem sku']}" : ''
  end

  def process_refunds(order, item)
    # Example logic to update total refunds
    # Add refund amount if present in the item data
    refund_amount = item['Refunded Amount'].to_f
    order.update(total_refunds: order.total_refunds.to_f + refund_amount)
  end


end
