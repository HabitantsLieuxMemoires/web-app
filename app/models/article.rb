class Article
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Taggable

  field :title,   type: String
  field :body,    type: String
  field :public,  type: Boolean, default: true
  field :locked,  type: Boolean, default: false

  validates :title,      presence: true, length: { in: 4..80 }
  validates :body,       presence: true, length: { maximum: 26000 }
end
