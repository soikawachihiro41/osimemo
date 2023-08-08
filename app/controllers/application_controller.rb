class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :login_required
  helper_method :logged_in?

  private

  def current_user
    # @current_userがnilでsession[:user_id]に値が入っている場合、ユーザーを持ってくる
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def login_required
    # ログインしていない（current_userが存在しない場合）root_pathに飛ばす
    redirect_to root_path unless current_user
  end

  def logged_in?
    !current_user.nil?
  end
end
