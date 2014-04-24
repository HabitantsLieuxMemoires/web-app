module SearchableByDateRange
  extend ActiveSupport::Concern

  module ClassMethods

    def in_range(query)
      if query.present?
        begin
          range = date_range(query)
          criteria.where(created_at: range[0]..range[1])
        rescue
          criteria
        end
      else
        criteria
      end
    end

    private

    def date_range(query)
      Hash[query.split('-').map.with_index {|x, i| [i, Date.strptime(x.strip, "%m/%d/%Y")]}]
    end

  end

end
