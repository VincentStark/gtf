class FeedbacksController < ApplicationController

  def new
    @feedback = Feedback.new
  end

  def create
    @feedback = Feedback.new(params[:feedback])
    
    if @feedback.valid?
      FeedbackMailer.new_message(@feedback).deliver
      redirect_to(root_path, :flash => { :success => 'Feedback was successfully sent, thank you!' })
    else
      flash.now[:error] = @feedback.errors.full_messages[0]
      render :new
    end
  end
end
