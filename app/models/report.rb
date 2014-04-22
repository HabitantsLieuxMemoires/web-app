class Report
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :description, type: String

  belongs_to :article
  belongs_to :user

  validates :description,  presence: true, length: { in: 4..1024 }
end
