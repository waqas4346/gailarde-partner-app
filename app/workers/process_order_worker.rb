class ProcessOrderWorker
    include Sidekiq::Worker

    def perform(order_data)
        byebug
        shopify_order_id = order_data["id"].to_s
        order = Order.find_or_initialize_by(shopify_order_id: shopify_order_id)
    
        partner = find_partner(order_data)
        residence = find_residence(order_data)
    
        if partner
          order.assign_attributes(
            status: "created",
            order_number: order_data['order_number'],
            order_date: order_data['created_at'],
            order_value: order_data['total_price'].to_f,
            currency: order_data['currency'],
            payment_status: order_data['financial_status'],
            first_name: order_data.dig('billing_address', 'first_name'),
            last_name: order_data.dig('billing_address', 'last_name'),
            email: order_data['email'],
            company: order_data.dig('billing_address', 'company'),
            address_1: order_data.dig('billing_address', 'address1'),
            address_2: order_data.dig('billing_address', 'address2'),
            zip_code: order_data.dig('billing_address', 'zip'),
            city: order_data.dig('billing_address', 'city'),
            country: order_data.dig('billing_address', 'country'),
            fulfillment_status: order_data['fulfillment_status'],
            tracking_number: order_data['fulfillments'].map { |f| f['tracking_number'] }.join(', '),
            student_id: student_id(order_data),
            arrival_date: arrival_date(order_data),
            products: products(order_data),
            partner: partner,
            residence: residence
          )
    
          order.items.destroy_all
    
          order_data['line_items'].each do |line_item|
            order.items.build(
              product_name: line_item['name'],
              sku: line_item['sku'],
              quantity: line_item['quantity'],
              price: line_item['price'].to_f,
              line_item_id: line_item["id"]
            )
          end
    
          order.save!
        end
    
    end

    private

    def find_partner(order_data)
        partner_parameter = order_data['note_attributes']&.find { |na| na['name'] == 'Partner Parameter' }&.dig('value')
        discount_code = order_data['discount_codes']&.first&.dig('code')
    
        Partner.find_by(parameter: partner_parameter) || Partner.find_by(discount_code: discount_code)
    end

    def find_residence(order_data)
        partner_parameter = order_data['note_attributes']&.find { |na| na['name'] == 'Residence' }&.dig('value')
        Residence.find_by(name: partner_parameter)
    end

    def student_id(order_data)
        order_data['note_attributes']&.find { |na| na['name'] == 'Student Id' }&.dig('value')
    end


    def arrival_date(order_data)
        order_data['note_attributes']&.find { |na| na['name'] == 'Arrival Date' }&.dig('value')
    end

    def products(order_data)
        order_data['line_items'].map { |item| "#{item['quantity']}x #{item['name']} | #{item['sku']}" }.join("<br>").html_safe
    end

end