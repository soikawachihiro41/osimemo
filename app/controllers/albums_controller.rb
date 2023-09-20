class AlbumsController < ApplicationController
  before_action :login_required, except: [:show, :public_index]

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

  def index #自分用
    @album = Album.find(params[:album_id])
    @photos = @album.photos
  end

  def public_index #みんなの公開アルバム
    @public_albums = Album.where(is_public: true)
  end
  
  def show
    @album = Album.find(params[:id])
  end
  
  def edit
    @album = Album.find(params[:id])
  end

  def update
    @album = Album.find(params[:id])
    if @album.update(album_params)
      redirect_to idol_album_path(@album.idol, @album), notice: 'アルバムが更新されました'
    else
      render :edit
    end
  end
  
  def destroy
    @album = Album.find(params[:id])
    @album.destroy

    flash[:notice] = "アルバムと関連する写真が削除されました。"
    redirect_to mypages_path
  end
  
  private

  def album_params
    params.require(:album).permit(:name, :cover_image, :idol_id, :is_public, :is_open)
  end
end
