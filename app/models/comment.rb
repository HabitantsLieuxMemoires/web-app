class Comment
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::MagicCounterCache
  include Mongoid::Alize

  include Trackable

  field :content, type: String

  belongs_to    :article
  counter_cache :article
  alize         :article, :title, :slug

  # Denormalize user
  belongs_to    :user
  counter_cache :user
  alize         :user, :nickname, :avatar_url

  validates :content, presence: true, length: { in: 4..1024 }
end
