class Article
  include Mongoid::Document
  include Mongoid::Timestamps

  include Mongoid::Taggable           # Tag management support
  include Mongoid::MagicCounterCache  # Counter cache support (allowing queries based on counter)
  include Mongoid::Slug               # Slug support

  include Trackable                   # History tracking support

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

  embeds_many :images
  embeds_many :videos

  has_many :comments, dependent: :delete
  has_many :reports,  dependent: :delete

  validates :title,      presence: true, length: { in: 4..80 }
  validates :body,       presence: true, length: { maximum: 26000 }
  validates :images,     associated: true
  validates :videos,     associated: true

  # History tracking
  track_history on: [:title, :body], track_create: true

  # ElasticSearch indexing
  searchkick    autocomplete: ['title']

  # Search scopes
  scope :newest, -> { desc(:created_at).limit(5) }

  # Filter fields to be indexed
  def search_data
    as_json only: [:_id, :title]
  end

end
