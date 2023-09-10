class UsersController < ApplicationController
  require 'net/http'
  require 'uri'
  def new
    if current_user
      redirect_to photos_path
    end
    gon.user_key = ENV['LINE_LIFF_SECRET']
  end

  def create
    id_token = params[:idToken]
    name = params[:name]
    channel_id = ENV.fetch('LINE_CHANNEL_SECRET')
    res = Net::HTTP.post_form(URI.parse('https://api.line.me/oauth2/v2.1/verify'), { 'id_token' => id_token, 'client_id' => channel_id })
    line_user_id = JSON.parse(res.body)['sub']
    @user = User.find_or_create_by(line_id: line_user_id) do |user|
      user.name = name
    end
    session[:user_id] = @user.id
    render json: @user
  end
  
  def destroy
    reset_session
    redirect_to root_path, notice: 'ログアウトしました'
  end  

  def edit
    # プロフィール編集画面を表示するための処理
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to mypages_path(tab: 'profile'), turbo_frame: "content"
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
end
