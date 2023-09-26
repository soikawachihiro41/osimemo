# frozen_string_literal: true

class IdolsController < ApplicationController
  before_action :login_required
  def index
    @idols = Idol.where(user_id: current_user.id)
  end

  def show
    @idol = Idol.find(params[:id])
  end

  def new
    @idol = Idol.new
    @idol.albums.build
  end

  def edit
    @idol = Idol.find(params[:id])
  end

  def create
    @idol = current_user.idols.build(idol_params)
    if @idol.save
      # 成功時のリダイレクト先をmypages_pathへ変更
      redirect_to mypages_path, success: '推しを正常に登録しました。'
    else
      # 失敗時の処理
      flash.now[:danger] = 'エラーが発生しました。入力内容を確認してください。'
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @idol = Idol.find(params[:id])
    if @idol.update(idol_params)
      redirect_to idol_path(@idol), success: '推しの情報を正常に更新しました。'
    else
      flash.now[:danger] = 'エラーが発生しました。入力内容を確認してください。'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @idol = Idol.find(params[:id])
    @idol.destroy
    redirect_to mypages_path, success: '推しを正常に削除しました。'
  end

  private

  def idol_params
    params.require(:idol).permit(:name, :birth_date, :is_selected)
  end
end
