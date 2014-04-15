class Image
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :title, type: String

  mount_uploader :article_image, ArticleImageUploader

  belongs_to :article

  validates :title, presence: true, length: { in: 4..256 }
end
