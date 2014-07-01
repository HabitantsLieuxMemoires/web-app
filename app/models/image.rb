class Image
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Timestamps::Created

  include Trackable

  field :title, type: String

  mount_uploader :article_image, ArticleImageUploader

  embedded_in :article

  validates :title, presence: true, length: { in: 4..80 }
  validates :article_image, presence: true

end
