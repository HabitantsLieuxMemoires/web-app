class Video
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Timestamps::Created

  include VideoEmbeddable
  include Trackable

  field :title, type: String
  field :url,   type: String

  embedded_in :article

  validates :title, presence: true, length: { in: 4..80 }
  validates :url, presence: true,   length: { in: 16..256 }, video_provider: true
end
