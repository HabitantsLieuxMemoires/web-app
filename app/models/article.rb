class Article
  include Mongoid::Document
  include Mongoid::Timestamps

  include Mongoid::Taggable           # Tag management support
  include Mongoid::MagicCounterCache  # Counter cache support (allowing queries based on counter)
  include Mongoid::Slug               # Slug support
  include Mongoid::Alize              # Denormalization

  include Trackable                   # History tracking support

  # Slug
  field :title,         type: String
  slug  :title

  field :body,          type: String
  field :public,        type: Boolean, default: true
  field :locked,        type: Boolean, default: false
  field :location,      type: String
  field :comment_count, type: Integer, default: 0 # Counter cache
  field :share_count,   type: Integer, default: 0

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

  # Indexes
  index({ share_count: 1 }, { background: true })

  # Validation
  validates :title,      presence: true, length: { in: 4..80 }
  validates :body,       presence: true, length: { maximum: 26000 }
  validates :images,     associated: true
  validates :videos,     associated: true

  # Search scopes
  scope :newest,      -> { desc(:created_at) }
  scope :most_shared, -> { desc(:share_count) }

  # ElasticSearch indexing
  searchkick    word_start: [:title], autocomplete: [:title]
  def search_data
    {
      _id:          _id,
      title:        title,
      tags:         tags_array,
      theme:        theme_id.to_s,
      share_count:  share_count
    }
  end

end
