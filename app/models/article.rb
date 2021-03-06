class Article
  include Mongoid::Document
  include Mongoid::Timestamps

  include Mongoid::Taggable           # Tag management support
  include Mongoid::MagicCounterCache  # Counter cache support (allowing queries based on counter)
  include Mongoid::Slug               # Slug support
  include Mongoid::Alize              # Denormalization
  include Mongoid::Paranoia           # Avoid destruction

  include Trackable
  include Searchable

  # Slug
  field :title,         type: String
  slug  :title

  field :body,          type: String
  field :comment_count, type: Integer, default: 0 # Counter cache
  field :share_count,   type: Integer, default: 0
  field :public,        type: Mongoid::Boolean, default: true
  field :published,     type: Mongoid::Boolean, default: false

  # Theme
  belongs_to    :theme, dependent: :nullify
  alize         :theme, :title, :slug
  counter_cache :theme

  # Chronology
  belongs_to    :chronology, dependent: :nullify
  alize         :chronology, :title
  counter_cache :chronology

  # Feature (optional)
  belongs_to :feature

  # Coordinates
  embeds_many :locations
  accepts_nested_attributes_for :locations, :allow_destroy => true

  # Media
  embeds_many :images
  embeds_many :videos
  embeds_many :links
  accepts_nested_attributes_for :links, :allow_destroy => true

  # Comments
  has_many :comments, dependent: :destroy

  # Reports
  has_many :reports,  dependent: :destroy

  # Indexes
  index({ share_count: 1, published: 1 }, { background: true })

  # Validation
  validates :title,      presence: true, length: { in: 4..80 }
  validates :body,       presence: true, length: { maximum: 160000 }, on: :update
  validates :images,     associated: true
  validates :videos,     associated: true

  # Scopes
  default_scope       -> { where(published: true) }
  scope :newest,      -> { desc(:created_at) }
  scope :most_shared, -> { desc(:share_count) }

end
