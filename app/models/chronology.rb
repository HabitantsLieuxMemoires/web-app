class Chronology
  include Mongoid::Document
  include Mongoid::Slug

  field :title, type: String
  slug  :title

  field :article_count, type: Integer, default: 0

  has_many :articles

  validates :title, presence: true, uniqueness: true, length: { in: 3..20 }

  scope :by_articles_count, -> { desc(:article_count).limit(5) }
end
