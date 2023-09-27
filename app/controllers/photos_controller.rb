# frozen_string_literal: true

# 写真投稿設定
class PhotosController < ApplicationController
  before_action :login_required, except: %i[show index]
  before_action :set_photo, only: %i[show update destroy]
  before_action :check_owner_or_uploader, only: %i[update destroy]
  before_action :set_albums, only: %i[new create update]

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
    # 自身がオーナーのアルバム
    @open_albums = Album.where(is_public: true, is_open: true).where.not(user_id: current_user)
  end

  def create
    set_selected_album
    @photo = Photo.create_with_tags(@album, photo_params, parsed_tag_list, current_user)
    if @photo.persisted?
      redirect_to mypages_path, notice: t('.success')
    else
      flash.now[:danger] = t('.error')
      render :new, status: :unprocessable_entity
    end
  end

  def update
    set_selected_album
    if @photo.update_photo_and_tags(photo_params.except(:tag_names), parsed_tag_list)
      redirect_to mypages_url(tab: 'photos'), notice: t('.success')
    else
      flash.now[:danger] = t('.error')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @photo.destroy
    redirect_to mypages_url(tab: 'photos'), notice: t('.success')
  end

  private

  def set_photo
    @photo = Photo.includes(:album).find(params[:id])
  end

  def check_owner_or_uploader
    return if @photo.viewable_or_editable_by?(current_user)

    redirect_to root_path, alert: t('photos.no_permission')
  end

  def set_selected_album
    selected_album_id = (params[:my_album_id].presence || params[:open_album_id])
    @album = Album.find(selected_album_id)
  end

  def parsed_tag_list
    params[:photo][:tag_names].presence&.split(',')
  end

  def photo_params
    params.require(:photo).permit(:image, :body, :album_id, :capture_date, :tag_names)
  end
end
