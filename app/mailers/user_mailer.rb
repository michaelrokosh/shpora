class UserMailer < ApplicationMailer
  default template_path: 'mailer/user_mailer'

  def earn_money(user_id)
    @user = User.find(user_id)

    mail(
      to: @user.email,
      subject: 'Awesome news! Earn money with us!'
    )
  end
end
