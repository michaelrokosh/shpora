class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :subdomain_view_path

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :password])
  end

  def subdomain_view_path
    prepend_view_path "app/views/#{request.subdomain}_subdomain" if request.subdomain.present?
  end
end
