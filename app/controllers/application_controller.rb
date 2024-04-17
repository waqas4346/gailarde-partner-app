class ApplicationController < ActionController::Base

  def redirect_to_root
    redirect_to root_path
  end
end
