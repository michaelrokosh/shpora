# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  def create
    if simple_captcha_valid?
      super
    else
      flash[:error] = I18n.t('simple_captcha.message.default')
      redirect_to request.referrer
    end
  end
end
