class Image
  module Trackable
    extend ActiveSupport::Concern

    included do
      include Mongoid::Audit::Trackable

      # Track history changes
      track_history on: [], scope: :article, track_create: true, track_destroy: true
    end
  end
end
