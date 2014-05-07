class Comment
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::MagicCounterCache
  include Mongoid::Alize

  field :content, type: String

  belongs_to    :article
  counter_cache :article

  # Denormalize user
  belongs_to :user
  alize :user, :nickname

  validates :content, presence: true, length: { in: 4..1024 }
end
