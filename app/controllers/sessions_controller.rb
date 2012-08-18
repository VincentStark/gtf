class SessionsController < ApplicationController
  protect_from_forgery :except => :destroy

  def create
    if params[:password] == "tRjeV6kD"
      session[:signed_in] = true
      head :ok
    else
      head :forbidden
    end
  end

  def destroy
    if session[:signed_in]
      reset_session
      head :ok
    else
      head :not_found
    end
  end
end
