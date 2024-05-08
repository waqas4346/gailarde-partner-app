class Api::PartnersController < ApplicationController

  def index
    @partners = Partner.all.where(active: true)
    render json: @partners
  end

end
