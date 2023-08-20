class PhotosController < ApplicationController

  def new
    @photo = Photo.new
  end
  
  def create
    @album = Album.find(params[:photo][:album_id])
    @photo = @album.photos.new(photo_params)
    tag_list = params[:photo][:tag_names].split(',') 
    if @photo.save
      @photo.save_tags(tag_list)
      redirect_to mypages_path, notice: '登録が完了しました'
    else
      flash.now[:danger] = 'エラーが発生しました。入力内容を確認してください。'
      render :new, status: :unprocessable_entity
    end
  end

  def index
    idol = Idol.find(params[:idol_id])
    @album = idol.albums.find(params[:album_id])
    @photos = @album.photos
  end
  
  private

  def photo_params
    params.require(:photo).permit(:image, :body, :album_id, :capture_date)
  end
end
