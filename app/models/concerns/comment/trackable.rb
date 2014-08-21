class Comment
  module Trackable
    extend ActiveSupport::Concern

    included do
      include PublicActivity::Model

      # Track activity (create/destroy only)
      tracked except: :update,
              content: ->(controller, model) { model.content },
              author:  ->(controller, model) { model.user_fields['nickname'] },
              title:   ->(controller, model) { model.article_fields['title'] },
              slug:    ->(controller, model) { model.article_fields['slug'] }
    end
  end
end
