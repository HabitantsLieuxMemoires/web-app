class Chronology
  include Mongoid::Document

  field :title, type: String

  has_many :articles

  validates :title, presence: true, uniqueness: true, length: { in: 3..20 }
end
