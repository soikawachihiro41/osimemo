class IdolsController < ApplicationController
  def new
    @idol = Idol.new
    @idol.albums.build
  end
  

  def create
    @idol = current_user.idols.build(idol_params) # current_userからの関連性を考慮した新しい推しを作成します。
    if @idol.save
      redirect_to @idol, notice: '推しとアルバムが正常に作成されました。'
    else
      render :new
    end
  end

  private

  def idol_params
    params.require(:idol).permit(:name, :birth_date, :is_selected, album_attributes: [:name])
    # album_attributesを使用して、ネストされたアルバム属性を許可します。
  end
end
