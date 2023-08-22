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
  
  def edit
    @photo = Photo.find(params[:id])
    @tag_names = @photo.tags.pluck(:tag_names).join(',')
  end
  
  def update
    @photo = Photo.find(params[:id])
    tag_list = params[:photo][:tag_names].split(',') if params[:photo][:tag_names].present?
    if @photo.update(photo_params.except(:tag_names))
      @photo.save_tags(tag_list)
      redirect_to mypages_url(tab: 'photos'), notice: '写真が正常に更新されました。'
    else
      render :edit
    end
  end

  def tag
    @photos = Photo.joins(:tags).where(tags: { tag_names: params[:tag] })
    render :index
  end
  
  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
  
    # 指定されたURLにリダイレクト
    redirect_to mypages_url(tab: 'photos'), notice: '写真が正常に削除されました。'
  end
  
    
  private

  def photo_params
    params.require(:photo).permit(:image, :body, :album_id, :capture_date, :tag_names)
  end
end
