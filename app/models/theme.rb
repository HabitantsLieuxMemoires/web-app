class Theme
  include Mongoid::Document

  field :title, type: String
  field :article_count, type: Integer, default: 0

  has_many :articles

  validates :title, presence: true, uniqueness: true, length: { in: 6..50 }

  scope :by_articles_count, -> { desc(:article_count).limit(5) }
end
