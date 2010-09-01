class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :logged_in?
  before_filter :check_client
  before_filter :set_current_user
  
  helper_method :logged_in?, :current_user_session, :current_user
  
  
  
  protected
    def set_current_user
      Authorization.current_user = current_user
    end
    
    def permission_denied
      flash[:error] = 'You are not authorized to access that page'
      redirect_to root_url
    end
  
  private
    def logged_in?
      unless current_user
        flash[:error] = "You must be logged in to access the site."
        redirect_to login_path
      end
    end

    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.record
    end
    
    def check_client
      @client = current_user.clients.first if current_user.clients.size == 1
    end
    

    

end
