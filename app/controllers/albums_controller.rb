class AlbumsController < ApplicationController
  before_action :set_idol

  def new
    @album = @idol.albums.new
  end

  def create
    @album = @idol.albums.new(album_params)

    if @album.save
      redirect_to idol_path(@idol), notice: 'Album was successfully created.'
    else
      render :new
    end
  end

  private

  def set_idol
    @idol = Idol.find(params[:idol_id])
  end

  def album_params
    params.require(:album).permit(:name)
  end
end
