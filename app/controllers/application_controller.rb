class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :only_signed_in

  add_flash_types :success, :danger

  helper_method :current_user, :user_signed_in?

  private
  def only_signed_in
    redirect_to new_session_path, danger: 'You cannot access this page. Please connect.' if !user_signed_in?
  end

  def only_signed_out
    redirect_to profile_path if user_signed_in?
  end

  def user_signed_in?
    !current_user.nil?
  end

  def current_user
    return nil if !session[:auth] || !session[:auth]['user_id']
    return @_user if @_user
    @_user = User.find_by_id(session[:auth]['user_id'])
  end
end
