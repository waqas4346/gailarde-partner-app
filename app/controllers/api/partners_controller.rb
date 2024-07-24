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

  def order_create
    byebug

    order_data = JSON.parse(request.body.read)
    status = request.headers['X-Shopify-Topic']
    shopify_order_id = order_data['order_id'].to_s || order_data['id'].to_s # Ensure it's a string

    partner_parameter = extract_partner_parameter(order_data)
    discount_code = extract_discount_code(order_data)

    partner = Partner.find_by(parameter: partner_parameter) || Partner.find_by(discount_code: discount_code)
    order = Order.find_or_initialize_by(shopify_order_id: shopify_order_id)

    if partner || order.partner_id
      order.assign_attributes(
        status: status,
        order_number: order_data['order_number'],
        order_date: order_data['created_at'],
        order_value: calculate_order_value(order_data),
        payment_status: order_data['financial_status'],
        first_name: order_data.dig('billing_address', 'first_name'),
        last_name: order_data.dig('billing_address', 'last_name'),
        email: order_data['email'],
        company: order_data.dig('billing_address', 'company'),
        address_1: order_data.dig('billing_address', 'address1'),
        address_2: order_data.dig('billing_address', 'address2'),
        zip_code: order_data.dig('billing_address', 'zip'),
        city: order_data.dig('billing_address', 'city'),
        fulfillment_status: order_data['fulfillment_status'],
        tracking_number: order_data.dig('fulfillments').map { |f| f['tracking_number'] }.join(', '),
        partner_id: partner.id || order.partner_id
      )
      order.save!

      # Update or create order items
      
      new_items = order_data['line_items'].map do |item|
        {
          sku: item['sku'],
          product_name: item['name'],
          quantity: item['quantity'],
          price: item['price']
        }
      end

      # Create or update order items
      new_items.each do |item|
        existing_item = order.items.find_by(sku: item[:sku])
        if existing_item
          existing_item.update(item)
        else
          order.items.create(item)
        end
      end

      # Destroy items that are no longer present in the new data
      order.items.where.not(sku: new_items.map { |i| i[:sku] }).destroy_all
    else
      render json: { message: 'No matching partner found' }, status: :not_found
    end
  end

  private

  def verify_shopify_webhook
    data = request.body.read
    digest = OpenSSL::Digest.new('sha256')
    hmac = Base64.strict_encode64(OpenSSL::HMAC.digest(digest, SHOPIFY_WEBHOOK_SECRET, data))

    unless ActiveSupport::SecurityUtils.secure_compare(hmac, request.headers['X-Shopify-Hmac-Sha256'])
      render json: { message: 'Unauthorized' }, status: :unauthorized
      return false
    end

    request.body.rewind
  end

  def extract_discount_code(order_data)
    discount_codes = order_data.dig('discount_codes')
    discount_codes.present? ? discount_codes.first['code'] : nil
  end

  def extract_partner_parameter(order_data)
    note_attributes = order_data.dig('note_attributes')
    partner_attribute = note_attributes&.find { |attr| attr['name'] == 'Partner Parameter' }
    partner_attribute ? partner_attribute['value'] : nil
  end

  def calculate_order_value(order_data)
    if order_data['status'] == 'cancelled'
      0
    else
      refunds = order_data['refunds'].flat_map { |r| r['transactions'] }.sum { |t| t['amount'].to_f }
      total = order_data['total_price'].to_f - refunds
      total
    end
  end
end
