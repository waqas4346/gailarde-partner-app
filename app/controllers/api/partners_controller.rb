class Api::PartnersController < ApplicationController
  # skip_before_action :authenticate_user!, only: [:index, :show] #
  def index
    @partners = Partner.all
    render json: @partners
  end
end
