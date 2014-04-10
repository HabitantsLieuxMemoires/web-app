class Comment
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :content, type: String

  belongs_to :article

  validates :content, presence: true, length: { in: 4..1024 }
end
