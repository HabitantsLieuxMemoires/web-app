class Image
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :title, type: String

  mount_uploader :article_image, ArticleImageUploader

  embedded_in :article

  validates :title, presence: true, length: { in: 4..80 }
  validates :article_image, presence: true, file_size: { maximum: 0.5.megabytes.to_i }
end
