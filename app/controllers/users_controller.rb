class UsersController < ApplicationController

  def show
    @user = User.find_by_username(params[:id])
  end

  def search
  	@user = User.find_by_username(user_params)
  	redirect_to user_path(@user)
  end

  private
    def user_params
      params.require(:user).permit(:username, :email)
    end
end
