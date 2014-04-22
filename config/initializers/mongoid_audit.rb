# initializer for mongoid-audit
require_dependency 'history_tracker.rb' if Rails.env == "development"

Mongoid::Audit.tracker_class_name = :article_history_tracker
Mongoid::Audit.current_user_method = :current_user
