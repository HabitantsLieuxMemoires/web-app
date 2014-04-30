class Video
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  include VideoEmbeddable

  field :title, type: String
  field :url,   type: String

  belongs_to :article

  validates :title, presence: true, length: { in: 4..80 }
  validates :url, presence: true,   length: { in: 16..256 }, video_provider: true
end
