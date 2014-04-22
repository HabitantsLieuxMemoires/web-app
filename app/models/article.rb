class Article
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Taggable
  include Mongoid::MagicCounterCache

  before_save :update_location

  attr_accessor :latitude, :longitude

  field :title,     type: String
  field :body,      type: String
  field :public,    type: Boolean, default: true
  field :locked,    type: Boolean, default: false
  field :location,  type: Array,   default: []

  belongs_to    :theme, dependent: :nullify
  counter_cache :theme

  belongs_to    :chronology, dependent: :nullify
  counter_cache :chronology

  has_many :comments, autosave: true
  has_many :images,   autosave: true

  validates :title,      presence: true, length: { in: 4..80 }
  validates :body,       presence: true, length: { maximum: 26000 }

  index({ location: "2d" }, { min: -200, max: 200 })

  private

  def update_location
    self.location = [longitude.to_f, latitude.to_f]
  end
end
