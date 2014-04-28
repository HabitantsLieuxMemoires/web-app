module Searchable
  extend ActiveSupport::Concern

  included do
    searchkick autocomplete: ['title']
  end

end
