class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :login_required
  helper_method :logged_in?
  add_flash_types :success, :info, :warning, :danger

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  rescue ActiveRecord::RecordNotFound
    session[:user_id] = nil
    nil
  end

  def login_required
    # ログインしていない（current_userが存在しない場合）root_pathに飛ばす
    redirect_to root_path unless current_user
  end

  def logged_in?
    !current_user.nil?
  end

  def user_signed_in?
    !!current_user # current_userがnilでなければtrueを返す
  end
end
