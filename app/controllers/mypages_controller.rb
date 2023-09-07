class MypagesController < ApplicationController
  before_action :login_required
  def index
    @selected_tab = params[:tab] || 'albums'
    @albums = current_user.albums
    @idols = current_user.idols
    @notification_setting = current_user.notification_setting
    @photos = Photo.joins(:album).where(
      "albums.user_id = :user_id OR photos.uploader_id = :user_id", user_id: current_user.id
    )
  end
  
  def tag
    @photos = Photo.joins(:tags).where(tags: { tag_names: params[:tag] })
    @selected_tab = 'photos'
    render :index
  end

  
  def notifications
    render partial: 'mypages/notifications_content'
  end

  def chekigraph
    render partial: 'mypages/chekigraph_content'
  end

  def members
    render partial: 'mypages/members_content'
  end

  def profile
    render partial: 'mypages/profile_content'
  end
end
