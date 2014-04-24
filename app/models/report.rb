class Report
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  include SearchableByDateRange

  paginates_per 25

  STATES = {:addressed => 'addressed', :not_addressed => 'not_addressed'}.freeze

  field :description, type: String
  field :state,       type: String, default: STATES[:not_addressed]

  belongs_to :article
  belongs_to :user

  validates :description,  presence: true, length: { in: 4..1024 }
  validates :state,        presence: true, inclusion: { in: STATES.values }

  def self.by_state(state)
    if state.present?
      state.eql?('all') ? criteria : criteria.where(:state => state)
    else
      criteria
    end
  end
end
