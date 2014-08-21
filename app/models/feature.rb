class Feature
  include Mongoid::Document

  field :title,       type: String
  field :description, type: String

  has_many :articles

  validates :title,       presence: true, length: { in: 4..80 }
  validates :description, presence: true, length: { maximum: 8096 }
end
