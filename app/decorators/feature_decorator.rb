class FeatureDecorator < ApplicationDecorator
  delegate :title
  decorates_association :articles

  def description
    raw(object.description)
  end
end
