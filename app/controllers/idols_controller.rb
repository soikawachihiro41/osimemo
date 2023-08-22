class IdolsController < ApplicationController
  def new
    @idol = Idol.new
    @idol.albums.build
  end

  def create
    @idol = current_user.idols.build(idol_params)
    if @idol.save
      # 成功時のリダイレクト先をmypages_pathへ変更
      redirect_to mypages_path, success: '推しを正常に登録しました。'
    else
      flash.now[:danger] = 'エラーが発生しました。入力内容を確認してください。'
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @idol = Idol.find(params[:id])
  end
  
  def index
    @idols = Idol.where(user_id: current_user.id)
  end

  private

  def idol_params
    params.require(:idol).permit(:name, :birth_date, :is_selected)
  end
end

