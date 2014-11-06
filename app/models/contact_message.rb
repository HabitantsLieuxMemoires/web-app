class ContactMessage
  include ActiveModel::Validations
  include ActiveModel::Conversion
  include Humanizer
  extend ActiveModel::Naming

  attr_accessor :name, :email, :subject, :body, :humanizer_answer, :humanizer_question_id

  validates :name, :email, :subject, :body, :presence => true
  validates :email, :format => { :with => %r{.+@.+\..+} }, :allow_blank => true

  require_human_on

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end
end
