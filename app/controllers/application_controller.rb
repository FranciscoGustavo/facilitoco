class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  layout :set_layout
  before_action :config_strog_params, if: :devise_controller?

  protected

  def set_layout
  	"application"
  end

  def config_strog_params
  	devise_parameter_sanitizer.permit(:sign_up,keys:[:username])
  end

end
