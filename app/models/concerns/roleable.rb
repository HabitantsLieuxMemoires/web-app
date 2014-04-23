module Roleable
  extend ActiveSupport::Concern

  included do
    field :roles, type: Array, :default => []

    index({ roles: 1 })
  end

  def with_roles=(roles)
    self.roles = roles if roles.is_a? Array
  end

  def add_role(role)
    self.roles ||= []
    self.roles << role if role
    self.roles.uniq!
  end

  def has_role?(role)
    self.roles.include?(role)
  end

  def remove_role(role)
    self.roles.delete_if { |r| r.casecmp(role) == 0 }
  end

end
