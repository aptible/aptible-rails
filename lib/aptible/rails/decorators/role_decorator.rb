class RoleDecorator < ApplicationDecorator
  def can?(scope, account)
    role_scopes = account_permissions(account).map(&:scope)
    role_scopes.include?('manage') || role_scopes.include?(scope)
  end

  def has?(scope, account)
    account_permissions(account).map(&:scope).include?(scope)
  end

  def cached_permissions
    garner.bind(h.controller.session_token) do
      object.permissions
    end
  end
end
