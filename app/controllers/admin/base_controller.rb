class Admin::BaseController < ApplicationController
  before_action :must_be_admin

  private

  def must_be_admin
    redirect_to root_path unless current_user && current_user.admin?
  end
end
