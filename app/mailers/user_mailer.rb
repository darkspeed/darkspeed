class UserMailer < ApplicationMailer
  def reset(user)
    @user = user
    mail(to: @user.email, subject: 'DarkSpeed Password Reset')
  end
end
