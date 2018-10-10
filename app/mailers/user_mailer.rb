class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: t("mailer.user_mailer.active")
  end

  def password_reset
    @greeting = t("mailer.user_mailer.hi")
    mail to: "to@example.org"
  end
end
