class Article
  include Mongoid::Document
  include Mongoid::Timestamps

  include Mongoid::Taggable           # Tag management support
  include Mongoid::MagicCounterCache  # Counter cache support (allowing queries based on counter)
  include Mongoid::Audit::Trackable   # History tracking support
  include Mongoid::Slug               # Slug support

  field :title,     type: String
  slug  :title

  field :body,      type: String
  field :public,    type: Boolean, default: true
  field :locked,    type: Boolean, default: false
  field :location,  type: String

  belongs_to    :theme, dependent: :nullify
  counter_cache :theme

  belongs_to    :chronology, dependent: :nullify
  counter_cache :chronology

  has_many :images,   autosave: true
  has_many :videos,   autosave: true
  has_many :comments
  has_many :reports

  validates :title,      presence: true, length: { in: 4..80 }
  validates :body,       presence: true, length: { maximum: 26000 }

  # History tracking
  track_history on: [:title, :body], track_create: true

  # ElasticSearch indexing
  searchkick    autocomplete: ['title']

  # Filter fields to be indexed
  def search_data
    as_json only: [:_id, :title]
  end

end
