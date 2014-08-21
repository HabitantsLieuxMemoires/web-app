class Link
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :title, type: String
  field :url,   type: String

  embedded_in :article

  validates :title, presence: true, length: { in: 4..256  }
  validates :url,   presence: true, length: { in: 8..2000 }
end
