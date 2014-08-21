require 'carrierwave/processing/mini_magick'

class ArticleImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    ActionController::Base.helpers.asset_path("article/default.png")
  end

  process :resize_to_fit => [800, 800]

  version :thumb, :from_version => :medium do
    process resize_to_fit: [150, 150]
  end

  version :medium, :from_version => :large do
    process resize_to_fit: [300, 300]
  end

  version :large do
    process resize_to_fit: [450, 450]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
