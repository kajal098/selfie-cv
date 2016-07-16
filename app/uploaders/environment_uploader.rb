# encoding: utf-8

class EnvironmentUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick
  include CarrierWave::Video  # for your video processing
  include CarrierWave::Video::Thumbnailer

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.id}"
  end

  def default_url
   ActionController::Base.helpers.asset_url("work.png")
  end

  version :thumb do
    process thumbnail: [{format: 'png', quality: 10, size: 192, strip: false, logger: Rails.logger}]
    def full_filename for_file
      png_name for_file, version_name
    end
  end

  def png_name for_file, version_name
    %Q{#{version_name}_#{for_file.chomp(File.extname(for_file))}.png}
  end

 

end
