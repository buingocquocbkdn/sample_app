class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    check_unthenticate user
  end

  def check_unthenticate user
    if user&.authenticate(params[:session][:password])
      check_active user
    else
      flash.now[:danger] = t "controllers.sessions.danger"
      render :new
    end
  end

  def check_active user
    if user.activated?
      log_in user
      if params[:session][:remember_me] == Settings.check_remember
        remember user
      else
        forget user
      end
      redirect_back_or user
    else
      flash.now[:danger] = t "controllers.sessions.danger"
      render :new
      flash[:warning] = t "controllers.sessions.not_active"
      redirect_to root_path
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end
end
