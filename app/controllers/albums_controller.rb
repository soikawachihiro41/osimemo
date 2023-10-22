# frozen_string_literal: true

# Albumsコントローラはアルバム関連の操作を管理します。
class AlbumsController < ApplicationController
  before_action :login_required, except: %i[show public_index]

  # 自分用
  def index
    @album = Album.find(params[:album_id])
    @photos = @album.photos
  end

  def show
    @album = Album.find(params[:id])
  end

  def new
    @album = Album.new
  end

  def edit
    @album = Album.find(params[:id])
  end

  def create
    @album = Album.new(album_params)
    @album.user_id = current_user.id
    if @album.save
      redirect_to mypages_url(tab: 'albums'), notice: t('albums.created')
    else
      flash.now[:danger] = t('albums.error')
      render :new, status: :unprocessable_entity
    end
  end

  # みんなの公開アルバム
  def public_index
    @search = Album.ransack(params[:q])
    @public_albums = @search.result.includes(:idol, :user).where(is_public: true)
  end  
  
  def update
    @album = Album.find(params[:id])
    if @album.update(album_params)
      redirect_to idol_album_path(@album.idol, @album), notice: t('albums.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy

    flash[:notice] = t('albums.deleted')
    redirect_to mypages_path
  end

  private

  def album_params
    params.require(:album).permit(:name, :cover_image, :idol_id, :is_public, :is_open)
  end
end
