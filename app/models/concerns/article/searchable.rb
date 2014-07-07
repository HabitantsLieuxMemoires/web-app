class Article
  module Searchable
    extend ActiveSupport::Concern

    included do
      # Plug searchkick indexing
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

      def should_index?
        published? # only index published articles
      end
    end

  end
end
