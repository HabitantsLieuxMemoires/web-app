class ArticleHistoryTracker
  include Mongoid::Audit::Tracker

  def tracked_changes
    @tracked_changes ||= (modified.keys | original.keys).inject(HashWithIndifferentAccess.new) do |h, k|
      h[k] = { from: original[k], to: modified[k] }.delete_if { |_, vv| vv.nil? }
      h
    end.delete_if { |k, v| v.blank? || !trackable_parent_class.tracked_field?(k) }
  end

  def tracked_edits
    @tracked_edits ||= tracked_changes.inject(HashWithIndifferentAccess.new) do |h, (k, v)|
      unless v[:from].blank? && v[:to].blank?
        if v[:from].blank?
          h[:add] ||= {}
          h[:add][k] = v[:to]
        elsif v[:to].blank?
          h[:remove] ||= {}
          h[:remove][k] = v[:from]
        else
          if v[:from].is_a?(Array) && v[:to].is_a?(Array)
            h[:array] ||= {}
            old_values = v[:from] - v[:to]
            new_values = v[:to] - v[:from]
            h[:array][k] = { add: new_values, remove: old_values }.delete_if { |_, vv| vv.blank? }
          else
            h[:modify] ||= {}
            h[:modify][k] = v
          end
        end
      end
      h
    end
  end

  private

  def trackable_parent_class
    association_chain.first["name"].constantize
  end

end
