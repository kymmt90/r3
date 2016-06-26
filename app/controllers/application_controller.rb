class ApplicationController < ActionController::Base
  include SessionsHelper
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound, ActionController::RoutingError, with: :error404
  rescue_from Exception, with: :error500

  private

  def check_logged_in
    unless logged_in?
      save_forwarding_url
      flash[:danger] = 'Please log in'
      redirect_to login_url
    end
  end

  def error404(e)
    render 'error404', status: 404, formats: [:html]
  end

  def error500(e)
    logger.error [e, *e.backtrace].join("\n")
    render 'error500', status: 500, formats: [:html]
  end
end
