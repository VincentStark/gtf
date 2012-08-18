module SessionsHelper
  def trusted_collector
    head :forbidden unless session[:signed_in]
  end
end
