module Trackable
  extend ActiveSupport::Concern

  included do
    include Mongoid::Audit::Trackable
    include Mongoid::Alize

    track_history on: [:title, :body], modifier_field: :author

    # Denormalize author fields
    alize :author, :nickname
  end

  module ClassMethods

    def tracked_field?(field, action = :update)
      tracked_fields_for_action(action).include? database_field_name(field)
    end

    def tracked_fields_for_action(action)
      case action.to_sym
      when :destroy then tracked_fields + reserved_tracked_fields
      else tracked_fields
      end
    end

    def tracked_fields
      @tracked_fields ||= fields.keys.select do |field|
        h = history_trackable_options
        (h[:on] == :all || h[:on].include?(field)) && !h[:except].include?(field)
      end - reserved_tracked_fields
    end

    def reserved_tracked_fields
      @reserved_tracked_fields ||= ["_id", history_trackable_options[:version_field].to_s, "#{history_trackable_options[:modifier_field]}_id"]
    end

  end
end

