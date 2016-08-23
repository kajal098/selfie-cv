# encoding: utf-8

class FileUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick


  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.id}"
  end

  def default_url
   ActionController::Base.helpers.asset_url("default.png")
  end

  # Create different versions of your uploaded files:
  version :thumb do
    process resize_and_pad: [64,64]
  end

 

end
