class Api::PartnersController < ApplicationController

  def index
    cached_partners = Rails.cache.fetch('active_partners') do
      partners = Partner.where(active: true)
      ActiveModelSerializers::SerializableResource.new(partners).as_json
    end
  
    render json: cached_partners
  end

  def day_times
    @day_times = WeekDaysTime.all
    render json: @day_times
  end

  def clear_cache
    Rails.cache.delete('active_partners')
    index()
  end

  def zip_codes
    @day_times = ZipCodeLogic.all
    render json: @day_times
  end

end
