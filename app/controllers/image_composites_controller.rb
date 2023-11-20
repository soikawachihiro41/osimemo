class ImageCompositesController < ApplicationController
  require 'open-uri'

  before_action :login_required

  def new
    @selected_photo = Photo.find_by(id: params[:photo_id])
    if @selected_photo.nil?
      redirect_to root_path, alert: "写真が見つかりません。"
    end
  end
    

  def create
    @photo = Photo.find(params[:composite][:photo_id])
    if @photo.present?
      composite_image = create_composite_image(@photo.image.url, params[:composite][:overlay], params[:composite][:x_offset], params[:composite][:y_offset], params[:composite][:width], params[:composite][:height])
      @photo.update(image: composite_image)
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

  def download_image(url)
    download = URI.open(url)
    File.open('temp_image.webp', 'wb:ASCII-8BIT') do |file|
      file.write(download.read)
    end
  end  

  def create_composite_image(base_image_url, overlay_image_name, x_offset, y_offset, width, height)
    # Download base image
    base_image_path = download_image(base_image_url)
    
    # Full path of overlay image
    overlay_image_path = Rails.root.join('public', 'assets', 'images', overlay_image_name).to_s.force_encoding("UTF-8")
    
    # Path for output image
    output_path = Rails.root.join('tmp', 'output.jpg').to_s
  
    Rails.logger.info "Base Image Path: #{base_image_path}"
    Rails.logger.info "Overlay Image Path: #{overlay_image_path}"
  
    MiniMagick::Tool::Convert.new do |convert|
      convert << base_image_path
      convert.merge! ["-resize", "400x400"]
      convert << overlay_image_path
      convert.merge! ["-resize", "#{width}x#{height}"]
      convert.merge! ["-gravity", "northwest"]
      convert.merge! ["-geometry", "+#{x_offset.to_i}+#{y_offset.to_i}"]
      convert << "-composite"
      convert << output_path
    end
  
    return output_path if File.exist?(output_path)
  end
end  
