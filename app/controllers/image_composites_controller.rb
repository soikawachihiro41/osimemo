class ImageCompositesController < ApplicationController
  before_action :login_required

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    if @photo.save
      # 画像合成のロジックをここに実装
      composite_image = create_composite_image(@photo.image.url, params[:overlay], params[:x_offset], params[:y_offset], params[:width], params[:height])
      @photo.update(composite_image_url: composite_image)
      redirect_to @photo
    else
      render :new
    end
  end

  def index
    # 現在のユーザーがアップロードした写真を取得
    @photos = Photo.where(uploader_id: current_user.id)
  end

  private

  def photo_params
    params.require(:photo).permit(:image)
  end

  def create_composite_image(base_image_url, overlay, x_offset, y_offset, width, height)
    Cloudinary::Uploader.upload(base_image_url,
      transformation: [
        { width: 500, height: 500, crop: :fill }, # ベース画像のサイズ調整（必要に応じて変更）
        { overlay: overlay, width: width, height: height, x: x_offset, y: y_offset, gravity: :north_west }
      ]
    )["url"]
  end  
end
