class Avatar
  include ActiveModel::Validations

  attr_accessor :avatar, :avatar_cache

  validates :avatar,                presence: true

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

end
