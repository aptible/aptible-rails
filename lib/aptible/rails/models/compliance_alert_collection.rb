class ComplianceAlertCollection
  def initialize(criteria, apps, users)
    @criteria = criteria
    @apps = apps
    @users = users
  end

  def all
    context = { users: @users, apps: @apps }
    @criteria.map do |criterion|
      CriterionAlertDecorator.decorate(criterion, context: context).alerts || []
    end.flatten
  end
end
