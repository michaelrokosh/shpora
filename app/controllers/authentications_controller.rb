class AuthenticationsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    if auth
      authentication = Authentication.find_by_provider_and_uid(auth.provider, auth.uid)
      if authentication
        authentication.update_omniauth!(auth)
        sign_in authentication.user, event: :authentication unless current_user
        redirect_to_next_page(authentication.user)
      elsif current_user
        authentication = current_user.apply_omniauth(auth)
        redirect_to_next_page(current_user)
      else
        @user = User.find_for_oauth(request.env["omniauth.auth"], session[:invite], current_user)
        if @user.persisted? && (authentication = @user.apply_omniauth(auth))
          sign_in @user, event: :authentication
          Onboard::User.perform(@user)
          redirect_to_next_page(@user)
        else
          session["devise.facebook_data"] = request.env["omniauth.auth"]
          redirect_to new_user_registration_url
        end
      end
    else
      flash[:notice] = "Could not authenticate you from external website"
      redirect_to :back
    end
  end

  def destroy
    @user ||= current_user
    auth = Authentication.find_by(id: params[:id], user: current_user)
    unless auth.unauthorize!
      flash[:notice] = "We cound not unauthorize you from #{auth.provider_name} at this moment. Try in a few minutes."
    end
    redirect_to :back
  end

  private

  def authentication_params
    params.require(:authentication).permit(:provider, :uid, :user_id, :token, :token_expires_at)
  end

  def redirect_to_next_page(user)
    next_page = if user.sign_in_count > 1
      after_sign_in_path_for(user)
    else
      after_sign_up_path_for(user)
    end
    redirect_to next_page
  end
end
