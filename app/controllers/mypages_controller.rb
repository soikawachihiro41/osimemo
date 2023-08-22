class MypagesController < ApplicationController
  def index
    @selected_tab = params[:tab] || 'albums'
    @albums = current_user.albums
    @idols = current_user.idols
    @photos = Photo.joins(:album).where(albums: { user_id: current_user.id })
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
