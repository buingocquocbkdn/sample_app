class PasswordResetsController < ApplicationController
  before_action :find_user_by_email, :valid_user, :check_expiration,
    only: [:edit, :update]
  def new; end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t "controllers.password_resets.sent_email"
      redirect_to root_path
    else
      flash.now[:danger] = t "controllers.password_resets.not_found"
      render :new
    end
  end

  def edit; end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, t("controllers.password_resets.pass_empty"))
      render :edit
    elsif @user.update_attributes(user_params)
      log_in @user
      flash[:success] = t "controllers.password_resets.update_success"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit :password, :password_confirmation
  end

  def find_user_by_email
    @user = User.find_by email: params[:email]
    return if @user
    flash[:danger] = t "controllers.password_resets.notfound"
    redirect_to root_path
  end

  def valid_user
    unless @user&.activated? &&
      @user.authenticated?(:reset, params[:id])
      redirect_to root_path
    end
  end

  def check_expiration
    return unless @user.password_reset_expired?
    flash[:danger] = t "controllers.password_resets.check_expiration"
    redirect_to new_password_reset_url
  end
end
