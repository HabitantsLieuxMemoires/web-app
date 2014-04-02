class User
  include Mongoid::Document
  include Mongoid::Enum
  include Mongoid::Timestamps::Created

  authenticates_with_sorcery!

  field :nickname, type: String

  enum :role, [:member, :moderator, :admin], :default => :member

  validates :password,                presence: true, confirmation: true, length: 8..50
  validates :email,                   presence: true, uniqueness: true, email: true
  validates :password_confirmation,   presence: true
  validates :nickname,                presence: true, uniqueness: true, length: 4..50
end
