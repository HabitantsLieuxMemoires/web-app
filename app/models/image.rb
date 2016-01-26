require 'file_size_validator'

class Image
  include Mongoid::Document
  include Mongoid::Paranoia
  include Mongoid::Timestamps::Created

  include Trackable

  attr_accessor :size

  field :title, type: String

  mount_uploader :article_image, ArticleImageUploader

  embedded_in :article

  validates :title, presence: true, length: { in: 4..80 }
  validates :article_image,
    :presence => true,
    :file_size => {
      :maximum => 2.megabytes.to_i
    }

end
