class PhotosController < ApplicationController
  before_action :login_required, except: %i[show index]
  before_action :set_photo, only: %i[show edit update destroy]
  before_action :check_owner_or_uploader, only: %i[edit update destroy]

  def new
    @photo = Photo.new
    # 自身がオーナーのアルバム
    @my_albums = Album.where(user_id: current_user.id)
    # 公開設定かつ写真追加が許可されているアルバム
    @open_albums = Album.where(is_public: true, is_open: true).where.not(user_id: current_user)
  end

  def create
    selected_album_id = (params[:my_album_id].presence || params[:open_album_id])
    @album = Album.find(selected_album_id)

    @photo = @album.photos.new(photo_params)
    tag_list = params[:photo][:tag_names].split(',')
    @photo.uploader_id = current_user.id
    if @photo.save
      @photo.save_tags(tag_list)
      redirect_to mypages_path, notice: '登録が完了しました'
    else
      # ここで@my_albumsと@open_albumsを再設定
      @my_albums = Album.where(user_id: current_user.id)
      @open_albums = Album.where(is_public: true, is_open: true).where.not(user_id: current_user)

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
    @album = Album.find(params[:album_id])
    unless @album.is_public || (user_signed_in? && @album.user_id == current_user.id)
      redirect_to root_path, alert: 'このアルバムは非公開です'
    end
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
    selected_album_id = (params[:my_album_id].presence || params[:open_album_id])
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
    # is_publicがtrueに設定されたアルバムのIDを取得
    public_album_ids = Album.where(is_public: true).pluck(:id)

    # タグに紐づいていて、かつ公開されているアルバムに所属している写真のみを取得
    @photos = Photo.joins(:tags,
                          :album).where(tags: { tag_names: params[:tag] }).where(albums: { id: public_album_ids })

    render :index
  end

  def destroy
    @photo.destroy
    redirect_to mypages_url(tab: 'photos'), notice: '写真が正常に削除されました。'
  end

  private

  def set_photo
    @photo = Photo.find(params[:id])
  end

  def check_owner_or_uploader
    return if current_user.id == @photo.album.user_id || current_user.id == @photo.uploader_id

    redirect_to root_path, alert: '権限がありません。'
  end

  def photo_params
    params.require(:photo).permit(:image, :body, :album_id, :capture_date, :tag_names)
  end
end
