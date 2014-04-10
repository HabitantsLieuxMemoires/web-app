class Article
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Taggable

  before_save :update_location

  attr_accessor :latitude, :longitude

  field :title,     type: String
  field :body,      type: String
  field :public,    type: Boolean, default: true
  field :locked,    type: Boolean, default: false
  field :location,  type: Array,   default: []

  validates :title,      presence: true, length: { in: 4..80 }
  validates :body,       presence: true, length: { maximum: 26000 }

  index({ location: "2d" }, { min: -200, max: 200 })

  has_many :comments, autosave: true

  private

  def update_location
    self.location = [longitude.to_f, latitude.to_f]
  end
end
