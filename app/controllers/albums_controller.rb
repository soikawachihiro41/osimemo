class AlbumsController < ApplicationController
  def new
    @album = Album.new
  end

  def create
    @album = Album.new(album_params)
    @album.user_id = current_user.id

    if @album.save
      redirect_to mypages_path, notice: 'アルバムが正常に作成されました。'
    else
      flash.now[:danger] = 'エラーが発生しました。入力内容を確認してください。'
      render :new
    end
  end

  def index
    @album = Album.find(params[:album_id])
    @photos = @album.photos
  end
  
  private

  def album_params
    params.require(:album).permit(:name, :cover_image, :idol_id)
  end
end
