class Article
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title
  field :body

  validates :title,      presence: true, length: 4..80
  validates :body,       presence: true
end
