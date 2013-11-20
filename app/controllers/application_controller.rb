class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :subdomain_view_path


  private

  def subdomain_view_path
    prepend_view_path "app/views/#{request.subdomain}_subdomain" if request.subdomain.present?
  end
end
