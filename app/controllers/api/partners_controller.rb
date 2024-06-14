class Api::PartnersController < ApplicationController

  def index
    cached_partners = Rails.cache.fetch('active_partners') do
      partners = Partner.where(active: true)
      ActiveModelSerializers::SerializableResource.new(partners).as_json
    end
  
    render json: cached_partners
  end

  def clear_cache
    Rails.cache.delete('active_partners')
    index()
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

  def shipping_threshold
    @shipping_threshold = FreeShippingThreshold.all
    render json: @shipping_threshold
  end

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

end
