class Article
  include Mongoid::Document
  include Mongoid::Timestamps

  include Mongoid::Taggable           # Tag management support
  include Mongoid::MagicCounterCache  # Counter cache support (allowing queries based on counter)
  include Mongoid::Slug               # Slug support
  include Mongoid::Alize              # Denormalization

  include Trackable                   # History tracking support

  field :title,     type: String
  slug  :title

  field :body,          type: String
  field :public,        type: Boolean, default: true
  field :locked,        type: Boolean, default: false
  field :location,      type: String
  field :comment_count, type: Integer, default: 0 # Counter cache

  # Theme
  belongs_to    :theme, dependent: :nullify
  counter_cache :theme
  alize         :theme, :title

  # Chronology
  belongs_to    :chronology, dependent: :nullify
  counter_cache :chronology
  alize         :chronology, :title

  # Feature (optional)
  belongs_to :feature

  # Media
  embeds_many :images
  embeds_many :videos

  # Comments
  has_many :comments, dependent: :delete

  # Reports
  has_many :reports,  dependent: :delete

  # Validation
  validates :title,      presence: true, length: { in: 4..80 }
  validates :body,       presence: true, length: { maximum: 26000 }
  validates :images,     associated: true
  validates :videos,     associated: true

  # History tracking
  track_history on: [:title, :body], track_create: true

  # ElasticSearch indexing
  searchkick    word_start: [:title], autocomplete: [:title]

  # Search scopes
  scope :newest, -> { desc(:created_at).limit(5) }

  # Filter fields to be indexed
  def search_data
    {
      _id:      _id,
      title:    title,
      tags:     tags_array,
      theme:    theme_id.to_s
    }
  end

end
