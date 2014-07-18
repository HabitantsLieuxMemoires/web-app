require 'carrierwave/processing/mini_magick'

class AvatarUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.id}"
  end

  def default_url
    ActionController::Base.helpers.asset_path("avatar/" + [version_name, "default.png"].compact.join('_'))
  end

  process :resize_to_fit => [150, 150]

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg png)
  end

end
