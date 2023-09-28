# frozen_string_literal: true

# This controller handles user interactions.
class UsersController < ApplicationController
  require 'net/http'
  require 'uri'
  def show
    @user = User.find(params[:id])
  end

  def new
    redirect_to after_login_path if current_user
    gon.user_key = ENV.fetch('LINE_LIFF_SECRET', nil)
  end

  def edit
    # プロフィール編集画面を表示するための処理
    @user = current_user
  end

  def create
    id_token = params[:idToken]
    name = params[:name]
    channel_id = ENV.fetch('LINE_CHANNEL_SECRET')
    # LINEのAPIにリクエストを送信してIDトークンを検証します
    res = Net::HTTP.post_form(URI.parse('https://api.line.me/oauth2/v2.1/verify'),
                              { 'id_token' => id_token, 'client_id' => channel_id })
    # レスポンスが成功であれば処理を進めます
    if res.is_a?(Net::HTTPSuccess)
      line_user_id = JSON.parse(res.body)['sub']
      # ユーザーが存在する場合はそのまま、存在しない場合は新規作成します
      @user = User.find_or_create_by(line_id: line_user_id) do |user|
        user.name = name
      end
      # セッションにユーザーIDを格納してログイン状態とします
      session[:user_id] = @user.id
      # JSON形式で@userオブジェクトをクライアントに返します
      render json: @user
    # レスポンスが成功でなければエラーを返します
    else
      logger.error "LINE APIからエラーレスポンスが返されました: #{res.body}"
      render json: { error: '認証に失敗しました' }, status: :unauthorized
    end
  # その他のエラー（例えばネットワークエラー、JSONの解析エラーなど）をキャッチします
  rescue StandardError => e
    logger.error "エラーが発生しました: #{e.message}"
    render json: { error: '内部エラー' }, status: :internal_server_error
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to mypages_path(tab: 'profile'), turbo_frame: 'content'
    else
      render :edit
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: t('.success')
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
end
