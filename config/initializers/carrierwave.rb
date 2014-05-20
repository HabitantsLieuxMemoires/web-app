CarrierWave.configure do |config|

  config.cache_dir = "#{Rails.root}/tmp/uploads"

  if Rails.env.test? || Rails.env.cucumber?
    config.storage = :file
    config.enable_processing = false

    # make sure our uploader is auto-loaded
    ArticleImageUploader

    # use different dirs when testing
    CarrierWave::Uploader::Base.descendants.each do |klass|
      next if klass.anonymous?
      klass.class_eval do
        def cache_dir
          "#{Rails.root}/spec/support/uploads/tmp"
        end

        def store_dir
          "#{Rails.root}/spec/support/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
        end
      end
    end
  end

  if Rails.env.development?
    config.storage = :file
  end

  if Rails.env.production?
    config.storage = :fog

    # Fog S3 configuration
    config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => ENV['S3_ACCESS_KEY'],
      :aws_secret_access_key  => ENV['S3_SECRET_KEY'],
      :region                 => ENV['S3_REGION'],
      :endpoint               => ENV['S3_ENDPOINT'],
      :path_style             => true
    }

    config.fog_directory    = ENV['S3_BUCKET']
  end
end
