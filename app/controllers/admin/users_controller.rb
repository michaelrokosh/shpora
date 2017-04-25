class Admin::UsersController < ApplicationController
  def index
    @users = User.order('created_at DESC').paginate(page: params[:page], per_page: 40)
  end

  def show

  end

  def relogin
    user = User.find_by(username: params[:id])
    sign_out current_user
    sign_in user
    redirect_to root_path
  end
end
