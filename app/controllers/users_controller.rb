class UsersController < ApplicationController

  skip_before_action :only_signed_in, only: [:new, :create, :confirm]
  before_action :only_signed_out, only: [:new, :create, :confirm]

  def new
    @user = User.new
  end

  def create
    user_params = params.require(:user).permit(:username, :email, :password, :password_confirmation)
    @user = User.new(user_params)

    if@user.valid?
      @user.save
      UserMailer.confirm(@user).deliver_now
      redirect_to new_session_path, success: 'Your account has been created. You should receive a confirmation email asap.'
    else
      render 'new'
    end
  end

  def confirm
    @user = User.find(params[:id])
    if @user.confirmation_token = params[:token]
      @user.update_attributes(confirmed: true, confirmation_token: nil)
      @user.save(validates: false)
      session[:auth] = @user.to_session
      redirect_to profile_path, success: 'Your account has been confirmed !'
    else
      redirect_to :root, danger: 'This token is invalid'
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    user_params = params.require(:user).permit(:username, :first_name, :last_name, :email, :avatar_file)
    if @user.update(user_params)
      redirect_to profile_path, success: 'Your account has been updated'
    else
      redirect_to 'edit'
    end
  end
end
