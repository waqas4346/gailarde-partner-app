class Api::PartnersController < ApplicationController
  # skip_before_action :authenticate_user!, only: [:index, :show] #
  # before_action :allow_iframe
  def index
    @partners = Partner.all
    render json: @partners
  end

  # def allow_iframe
  #   response.headers['Content-Security-Policy'] = 'frame-ancestors none;'
  # end
end
