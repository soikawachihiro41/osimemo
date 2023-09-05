class PhotosController < ApplicationController

  def new
    @photo = Photo.new
    # 自身がオーナーのアルバム
    @my_albums = Album.where(user_id: current_user.id)
    # 公開設定かつ写真追加が許可されているアルバム
    @open_albums = Album.where(is_public: true, is_open: true).where.not(user_id: current_user)
  end
  
  def create
    selected_album_id = params[:my_album_id].present? ? params[:my_album_id] : params[:open_album_id]
    @album = Album.find(selected_album_id)
    
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

  def show
    @photo = Photo.find(params[:id])
    @album = Album.find(@photo.album_id)
    @tag_names = @photo.tags.pluck(:tag_names)
  end
  
  def index
    idol = Idol.find(params[:idol_id])
    @album = idol.albums.find(params[:album_id])
    @photos = @album.photos
  end
  
  def edit
    @photo = Photo.find(params[:id])
    # 自身がオーナーのアルバム
    @my_albums = Album.where(user_id: current_user.id)
    # 公開設定かつ写真追加が許可されているアルバム
    @open_albums = Album.where(is_public: true, is_open: true).where.not(user_id: current_user.id)
    @tag_names = @photo.tags.pluck(:tag_names).join(',')
  end
  
  # PhotosController 内の update メソッド
def update
  selected_album_id = params[:my_album_id].present? ? params[:my_album_id] : params[:open_album_id]
  @album = Album.find(selected_album_id)
  
  @photo = Photo.find(params[:id])
  tag_list = params[:photo][:tag_names].presence&.split(',')
  
  if @photo.update(photo_params.except(:tag_names))
    @photo.album = @album
    @photo.save_tags(tag_list || [])
    @photo.save
    redirect_to mypages_url(tab: 'photos'), notice: '写真が正常に更新されました。'
  else
    flash.now[:danger] = 'エラーが発生しました。入力内容を確認してください。'
    render :edit, status: :unprocessable_entity
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
