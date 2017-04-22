class CallbacksController < Devise::OmniauthCallbacksController
  def facebook
    social_auth
  end

  def google_oauth2
    social_auth
  end

  private

  def failure
    redirect_to root_path
  end

  def social_auth
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end
