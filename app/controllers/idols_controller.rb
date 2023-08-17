class IdolsController < ApplicationController
  def new
    @idol = Idol.new
    @idol.albums.build
  end
  

  # app/controllers/idols_controller.rb

  def create
    @idol = current_user.idols.build(idol_params)
    if @idol.save
      redirect_to new_idol_album_path(@idol), success: '推しを正常に登録しました。続いてアルバムを登録してください。'
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
