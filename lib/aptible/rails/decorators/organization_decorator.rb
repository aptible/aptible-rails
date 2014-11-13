class OrganizationDecorator < ApplicationDecorator
  # rubocop:disable PredicateName
  def has_provisioned_account?
    object.accounts.any?(&:activated)
  end
  # rubocop:enable PredicateName

  def needs_startup_guide?
    object.accounts.count == 1 &&
      object.accounts.first.decorate.needs_startup_guide?
  end
end
