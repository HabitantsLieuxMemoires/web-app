class Location
  include Mongoid::Document

  field :coordinates, type: String

  embedded_in :article

  validates :coordinates, presence: true
end
