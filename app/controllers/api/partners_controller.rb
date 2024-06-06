class Api::PartnersController < ApplicationController

  def index
    cached_partners = Rails.cache.fetch('active_partners') do
      partners = Partner.where(active: true)
      ActiveModelSerializers::SerializableResource.new(partners).as_json
    end
  
    render json: cached_partners
  end

  def day_times
    @partners = WeekDaysTime.all
    render json: @partners
  end

  def clear_cache
    Rails.cache.delete('active_partners')
    render json: { message: 'Cache cleared successfully' }
  end

end
