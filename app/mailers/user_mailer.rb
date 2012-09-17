class UserMailer < ActionMailer::Base
  default from: "welcome@global-trend-finder.com"

  def welcome_email(user)
    @user = user
    mail(:to => @user.email, :subject => "Your registration on Global Trend Finder")
  end
end
