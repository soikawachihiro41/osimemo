# frozen_string_literal: true

class NotificationSettingsController < ApplicationController
  before_action :login_required
  def new
    @notification_setting = NotificationSetting.new
  end

  def create
    # 現在のユーザーがすでに通知設定を持っているか確認
    existing_setting = NotificationSetting.find_by(user_id: current_user.id)

    if existing_setting
      # すでに設定があればそれを更新
      if existing_setting.update(notification_setting_params)
        redirect_to root_path, notice: '設定が更新されました'
      else
        render :new
      end
    else
      # 新しく設定を作成
      @notification_setting = NotificationSetting.new(notification_setting_params)
      @notification_setting.user_id = current_user.id

      if @notification_setting.save
        redirect_to root_path, notice: '設定が保存されました'
      else
        render :new
      end
    end
  end

  private

  def notification_setting_params
    params.require(:notification_setting).permit(:preferred_time)
  end
end
