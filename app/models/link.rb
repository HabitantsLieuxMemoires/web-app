class Link
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :url, type: String

  embedded_in :article

  validates :url, presence: true, length: { in: 8..2000 }
end
