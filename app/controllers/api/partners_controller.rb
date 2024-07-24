class Api::PartnersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    cached_partners = Rails.cache.fetch('active_partners') do
      partners = Partner.where(active: true)
      ActiveModelSerializers::SerializableResource.new(partners).as_json
    end
  
    render json: cached_partners
  end

  def active_partners
    parameter = params[:parameter]
    partners = Partner.where(active: true, parameter: parameter)
  
    partners_array = partners.map do |partner|
      {
        id: partner.id,
        name: partner.name,
        parameter: partner.parameter,
        banner: partner.banner,
        banner_info: partner.banner_info,
        logo: partner.logo
      }
    end
    render json: partners_array
  end

  def clear_cache
    if Rails.cache.delete('active_partners')
      render json: { message: "Cache is cleared" }
        
    else
      render json: { message: "Cache not cleared" } 
    end
  end

  def zip_codes_logic
    @zip_codes_logic = ZipCodeLogic.all
    render json: @zip_codes_logic
  end

  def day_times_logic
    @day_times = WeekDaysTime.all
    render json: @day_times
  end

  def countries_logic
    @countries_logic = CountryLogic.all
    render json: @countries_logic
  end

  def zip_code_shippings
    @zip_code_shippings = ShippingMethodsWithZipcode.all
    render json: @zip_code_shippings
  end

  def weekend_shippings
    @weekend_shippings = WeekendShippingMethod.all
    render json: @weekend_shippings
  end

  # def shipping_threshold
  #   @shipping_threshold = FreeShippingThreshold.all
  #   render json: @shipping_threshold
  # end

  def shipping_infos
    @shipping_infos = ShippingInfo.all
    render json: @shipping_infos
  end

  def holidays
    @holidays = Holiday.all
    render json: @holidays
  end

  def shipping_custom_message
    @shipping_custom_message = ShippingCustomMessage.last
    render json: @shipping_custom_message
  end

  def orders_create
    process_order(params)
  end

  def orders_updated
    process_order(params)
  end

  def orders_refund
    order = Order.find_by(shopify_order_id: params[:id])

    if order
      # Calculate and update the refund amount
      refund_amount = params[:refunds].sum { |refund| refund[:transactions].sum { |transaction| transaction[:amount].to_f } }
      order.update(order_value: order.order_value - refund_amount)

      # Save refund details if necessary
      order.update(total_refunds: order.total_refunds.to_f + refund_amount)
    end

    head :ok
  end

  def orders_fulfillment
    order = Order.find_by(shopify_order_id: params[:id])

    if order
      # Update fulfillment status
      order.update(fulfillment_status: params[:fulfillment_status], status: "fulfilled")

      # Update tracking numbers
      tracking_numbers = params[:fulfillments].map { |f| f[:tracking_number] }.reject(&:blank?)
      order.update(tracking_number: tracking_numbers.join(', '))
    end

    head :ok
  end

  def orders_cancel
    order = Order.find_by(shopify_order_id: params[:id])

    if order
      # Update the order status to cancelled
      order.update(
        status: 'cancelled',
        cancellation_date: Time.current, # Set the cancellation date to the current time
        cancellation_reason: params.dig(:cancel_reason) || 'No reason provided'
      )
    end

    head :ok
  end

  private

  def process_order(order_data)
    shopify_order_id = order_data[:id].to_s
    order = Order.find_or_initialize_by(shopify_order_id: shopify_order_id)

    partner = find_partner(order_data)

    if partner
      order.assign_attributes(
        status: "created",
        order_number: order_data[:order_number],
        order_date: order_data[:created_at],
        order_value: order_data[:total_price].to_f,
        currency: order_data[:currency],
        payment_status: order_data[:financial_status],
        first_name: order_data.dig(:billing_address, :first_name),
        last_name: order_data.dig(:billing_address, :last_name),
        email: order_data[:email],
        company: order_data.dig(:billing_address, :company),
        address_1: order_data.dig(:billing_address, :address1),
        address_2: order_data.dig(:billing_address, :address2),
        zip_code: order_data.dig(:billing_address, :zip),
        city: order_data.dig(:billing_address, :city),
        country: order_data.dig(:billing_address, :country),
        fulfillment_status: order_data[:fulfillment_status],
        tracking_number: order_data[:fulfillments].map { |f| f[:tracking_number] }.join(', '),
        partner: partner
      )

      order.items.destroy_all

      order_data[:line_items].each do |line_item|
        order.items.build(
          product_name: line_item[:name],
          sku: line_item[:sku],
          quantity: line_item[:quantity],
          price: line_item[:price].to_f
        )
      end

      order.save!
    end

    head :ok
  end

  def find_partner(order_data)
    partner_parameter = order_data[:note_attributes]&.find { |na| na[:name] == 'Partner Parameter' }&.dig(:value)
    discount_code = order_data[:discount_codes]&.first&.dig(:code)

    Partner.find_by(parameter: partner_parameter) || Partner.find_by(discount_code: discount_code)
  end


end
