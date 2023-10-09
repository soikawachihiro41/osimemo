# frozen_string_literal: true

# 写真投稿設定
class PhotosController < ApplicationController
  before_action :login_required, except: %i[show index]
  before_action :set_photo, only: %i[edit show update destroy]
  before_action :check_owner_or_uploader, only: %i[update destroy]
  before_action :set_albums, only: %i[new edit]
  before_action :set_selected_album, only: %i[create update]

  def index
    @album = Album.includes(:photos).find(params[:album_id])
    redirect_to root_path, alert: t('photos.unauthorized') unless @album.viewable_by?(current_user)
    @photos = @album.photos
  end

  def show
    @album = @photo.album
    @tag_names = @photo.tag_names
  end

  def new
    @photo = Photo.new
  end

  def edit
    @tag_names = @photo.tags.pluck(:tag_names).join(',')
  end

  def create
    set_selected_album
    @photo = Photo.create_with_tags(@album, photo_params, current_user)
    @photo.save_tags(parsed_tag_list) if parsed_tag_list.present?
  
    if @photo.save
      redirect_to mypages_path, notice: t('photos.created')
    else
      set_albums  # ここで必要な変数を設定
      flash.now[:danger] = @photo.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end
  
  
  def update
    set_selected_album
    if @photo.update_photo_and_tags(photo_params.except(:tag_names), parsed_tag_list)
      redirect_to mypages_url(tab: 'photos'), notice: t('photos.update')
    else
      flash.now[:danger] = @photo.errors.full_messages.to_sentence
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
    redirect_to mypages_url(tab: 'photos'), notice: t('photos.deleted')
  end

  private

  def set_photo
    @photo = Photo.includes(:album).find(params[:id])
  end

  def set_selected_album
    selected_album_id = params[:my_album_id].presence || params[:open_album_id].presence
    
    unless selected_album_id
      redirect_to new_photo_path, alert: 'アルバムを選択してください'
      return
    end
    
    @album = Album.find(selected_album_id)
  end

  def check_owner_or_uploader
    return if current_user.admin? || @photo.viewable_or_editable_by?(current_user)
  
    redirect_to root_path, alert: t('photos.no_permission')
  end  

  def set_albums
    @my_albums = Album.where(user_id: current_user.id)
    @open_albums = Album.where(is_public: true, is_open: true).where.not(user_id: current_user.id)
  end

  def parsed_tag_list
    params[:photo][:tag_names].presence&.split(',')
  end

  def photo_params
    params.require(:photo).permit(:image, :body, :album_id, :capture_date, :tag_names)
  end
end
