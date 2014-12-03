class ComplianceAlertCollection
  def initialize(criteria, apps, users)
    @criteria = criteria
    @apps = apps
    @users = users
  end

  def all
    context = { users: @users, apps: @apps }
    @criteria.reduce([]) do |memo, criterion|
      criterion = CriterionAlertDecorator.decorate(criterion, context: context)
      memo + (criterion.alerts || [])
    end
  end
end
