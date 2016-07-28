class RoleDecorator < ApplicationDecorator
  def has?(scope, account)
    account_permissions(account).map(&:scope).include?(scope)
  end

  def cached_permissions
    garner.bind(h.controller.session_token) do
      object.permissions
    end
  end
end
