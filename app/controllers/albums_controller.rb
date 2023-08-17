class AlbumsController < ApplicationController
  before_action :set_idol

  def new
    @album = @idol.albums.new
  end

  def create
    @album = @idol.albums.new(album_params)
    @album.user_id = current_user.id
    if @album.save
      redirect_to mypages_path, notice: 'アルバムが正常に作成されました。'
    else
      flash.now[:danger] = 'エラーが発生しました。入力内容を確認してください。'
      render :new
    end
  end
  
  def index
    @albums = @idol.albums.all
  end
  
  private

  def set_idol
    @idol = Idol.find(params[:idol_id])
  end

  def album_params
    params.require(:album).permit(:name, :cover_image)
  end
end
