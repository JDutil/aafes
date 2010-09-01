class UserSessionsController < ApplicationController
  skip_before_filter :logged_in?, :except => :destroy
  skip_before_filter :check_client
  
  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      redirect_to root_path, :notice => "Login successful!"
    else
      render :action => :new
    end
  end

  def destroy
    current_user_session.destroy
    redirect_to login_path, :notice => "Logout successful!"
  end
end