# frozen_string_literal: true

# MypagesController handles the user's personal page actions.
class MypagesController < ApplicationController
  before_action :login_required
  def index
    @selected_tab = params[:tab] || 'photos'
    @idols = current_user.idols
    @notification_setting = current_user.notification_setting
  
    if current_user.admin?
      @albums = Album.all
      @photos = Photo.all
    else
      @albums = current_user.albums
      @photos = Photo.joins(:album).where(
        'albums.user_id = :user_id OR photos.uploader_id = :user_id', user_id: current_user.id
      )
    end
  end

  def tag
    # 現在のユーザーが所有している公開されているアルバムのIDを取得
    public_album_ids = current_user.albums.where(is_public: true).pluck(:id)

    # タグに紐づいていて、かつ公開されているアルバムに所属している（またはアップロード者が現在のユーザーである）写真のみを取得
    @photos = Photo.joins(:tags, :album).where(tags: { tag_names: params[:tag] }).where(
      'albums.id IN (:public_album_ids) OR photos.uploader_id = :user_id', public_album_ids:, user_id: current_user.id
    )

    @selected_tab = 'photos'
    render :index
  end

end
