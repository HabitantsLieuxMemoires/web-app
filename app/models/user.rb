class User
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::Alize

  include Roleable

  authenticates_with_sorcery!

  field :nickname,    type: String
  field :warn_count,  type: Integer, default: 0

  has_many :articles

  has_many :reports
  has_many :comments

  validates :password,                presence: true, confirmation: true, length: { in: 8..50 }
  validates :email,                   presence: true, uniqueness: true, email: true
  validates :password_confirmation,   presence: true
  validates :nickname,                presence: true, uniqueness: true, length: { in: 4..50 }
end
