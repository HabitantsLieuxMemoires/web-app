class ChangePassword
  include ActiveModel::Validations

  attr_accessor :password, :password_confirmation

  validates :password,                presence: true, confirmation: true, length: { in: 8..50 }
  validates :password_confirmation,   presence: true

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

end
