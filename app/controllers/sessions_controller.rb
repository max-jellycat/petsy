class SessionsController < ApplicationController

  skip_before_action :only_signed_in, only: [:new, :create, :destroy]
  before_action :only_signed_out, only: [:new, :create]

  def new
  end

  def create
    user_params = params.require(:user)
    @user = User.where(username: user_params[:username]).or(User.where(email: [user_params[:username]])).first

    if @user and @user.authenticate(user_params[:password])
      if @user.confirmed
        session[:auth] = @user.to_session
        redirect_to profile_path, success: 'You are now logged in'
      else
        redirect_to new_session_path, danger: 'Your account has not been confirmed, please check your emails for the confirmation link'
      end
    else
      redirect_to new_session_path, danger: 'Invalid credentials. Please try again.'
    end
  end

  def destroy
    session.destroy
    redirect_to new_session_path, success: 'You are now logged out'
  end
end
