class FeatureDecorator < ApplicationDecorator
  delegate :title, :to_key, :persisted?
  decorates_association :articles

  def description
    raw(object.description)
  end
end
