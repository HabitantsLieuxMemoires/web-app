require 'carrierwave/processing/mini_magick'

class ArticleImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Create different versions of your uploaded files:
  version :thumb do
    process resize_to_fit: [150, 150]
  end

  def default_url
    ActionController::Base.helpers.asset_path("article/default.png")
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
