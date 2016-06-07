class ApplicationController < ActionController::Base
  include SessionsHelper
  protect_from_forgery with: :exception


  private

  def check_logged_in
    unless logged_in?
      save_forwarding_url
      flash[:danger] = 'Please log in'
      redirect_to login_url
    end
  end
end
