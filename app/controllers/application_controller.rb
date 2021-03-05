class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  
  include SessionsHelper

  protected

  def require_login
    unless logged_in?
      session[:prelogin_url] = request.fullpath
      flash.now[:error] = "You must be logged in to access this page."
      render template: "sessions/new", status: :unauthorized and return
    end
  end
end
