class Chronology
  include Mongoid::Document
  include Mongoid::Slug
  include Mongoid::Alize
  include Mongoid::Timestamps::Created


  field :title, type: String
  slug  :title

  field :article_count, type: Integer, default: 0

  has_many :articles

  validates :title, presence: true, uniqueness: true, length: { in: 3..20 }

  scope :by_articles_count, -> { desc(:article_count).limit(5) }
  scope :by_creation_date, -> { desc(:created_at) }

end
