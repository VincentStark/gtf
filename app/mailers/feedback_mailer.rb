class FeedbackMailer < ActionMailer::Base

  default from: "feedback@global-trend-finder.com"
  default to: "nobody@noname.com"

  def new_message(feedback)
    @feedback = feedback
    mail(:subject => "[global-trend-finder] Feedback from #{@feedback.name}")
  end
end
