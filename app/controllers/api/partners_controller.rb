class Api::PartnersController < ApplicationController

  def index
    @partners = Partner.all.where(active: true)
    render json: @partners
  end

  def day_times
    @partners = WeekDaysTime.all
    render json: @partners
  end

end
