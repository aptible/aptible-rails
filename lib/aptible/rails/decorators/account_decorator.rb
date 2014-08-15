class AccountDecorator < ApplicationDecorator
  def needs_startup_guide?
    object.apps.count == 0 && object.databases.count == 0
  end

  def cached_permissions
    garner.bind(h.controller.session_token) do
      object.permissions
    end
  end

  # rubocop:disable PredicateName
  def has_scope?(scope)
    cached_permissions.map(&:scope).include? scope
  end
  # rubocop:enable PredicateName
end
