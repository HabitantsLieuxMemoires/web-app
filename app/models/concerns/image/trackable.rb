module Image::Trackable
  extend ActiveSupport::Concern

  included do
    include Mongoid::Audit::Trackable
    include Mongoid::Alize

    track_history on: [], scope: :article, track_create: true, track_destroy: true
  end
end
