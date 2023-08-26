class NotificationSettingsController < ApplicationController
  def new
    @notification_setting = NotificationSetting.new
  end

  def create
    @notification_setting = NotificationSetting.new(notification_setting_params)
    @notification_setting.user_id = current_user.id  # 仮にcurrent_userというメソッドがユーザー情報を返すとして
    if @notification_setting.save
      redirect_to root_path, notice: '設定が保存されました'
    else
      render :new
    end
  end

  private

  def notification_setting_params
    params.require(:notification_setting).permit(:preferred_time)
  end
end

