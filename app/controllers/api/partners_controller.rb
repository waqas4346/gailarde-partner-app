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
    parameter = params[:parameter].downcase
    partners = Partner.where("active = ? AND lower(parameter) = ?", true, parameter)
  
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

  def order_webhooks
    topic = request.headers["X-Shopify-Topic"]

    order_data = params.permit!.to_h

    case topic
    when "orders/create"
      ProcessOrderWorker.perform_async(order_data)
    when "refunds/create"
      OrdersRefundWorker.perform_async(order_data["order_id"], order_data)
    when "orders/fulfilled"
      OrdersFulfillmentWorker.perform_async(order_data["id"], order_data["fulfillment_status"], order_data["fulfillments"])
    when "orders/cancelled"
      OrdersCancelWorker.perform_async(order_data["id"], order_data["cancel_reason"])
    end
  end

end
