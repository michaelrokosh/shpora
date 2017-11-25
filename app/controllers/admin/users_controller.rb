class Admin::UsersController < Admin::BaseController
  def index
    @q = User.ransack(params[:q])
    @users = @q.result
               .order('created_at DESC')
               .paginate(page: params[:page], per_page: 40)
  end

  def show
    @user = User.find_by(username: params[:id])
  end

  def earn_money_news
    user = User.find_by(username: params[:id])
    UserMailer.earn_money(user.id).deliver_later
    redirect_to admin_users_path, notice: "Email has been sent to #{user.username}"
  end

  def news
    User.find_each { |user| UserMailer.earn_money(user.id).deliver_later }
    redirect_to admin_users_path, notice: "Emails gone."
  end

  def relogin
    user = User.find_by(username: params[:id])
    sign_out current_user
    sign_in user
    redirect_to root_path
  end

  def destroy
    user = User.find_by(username: params[:id])
    user.destroy
    redirect_to admin_users_path
  end
end
