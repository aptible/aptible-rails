class CriterionAlertDecorator < Draper::Decorator
  def alerts
    return [] if object.status == 'green'
    send "#{object.handle}_alerts"
  end

  def risk_assessment_alerts
    risk_url = Compliance::Application.routes.url_helpers.aptible_risk_path

    [Alert.new(subject: 'Risk Assessment', requirement: 'needs to be completed',
               subject_href: risk_url, cta: 'Complete Risk Assessment')]
  end

  def policy_manual_alerts
    policy_url = Compliance::Application.routes.url_helpers.aptible_policy_path

    [Alert.new(subject: 'Policy Manual', requirement: 'needs to be completed',
               subject_href: policy_url, cta: 'Complete Policy Manual')]
  end

  def app_security_interview_alerts
    all_apps.map do |app|
      next [] if completed_apps.any? { |href| href == app.href }
      app_path = Aptible::Security::Engine.routes.url_helpers
                 .app_path(id: app.id)
      [Alert.new(subject: app.handle, subject_href: app_path,
                 requirement: 'needs an App Security Interview',
                 cta: 'Complete App Security Interview')]
    end
  end

  def training_log_alerts
    all_users.map do |user|
      next [] if completed_users.any? { |href| href == user.href }
      user_path = Aptible::Training::Engine.routes.url_helpers.root_path
      [Alert.new(subject: user.name, subject_href: user_path,
                 requirement: 'needs Basic HIPAA Training',
                 cta: 'Complete Training')]
    end
  end

  def completed_users
    object.documents.map { |d| d.links['user'].href }.uniq
  end

  def completed_apps
    object.documents.map { |d| d.links['app'].href }.uniq
  end

  def all_users
    context[:users]
  end

  def all_apps
    context[:apps]
  end

  def method_missing(method)
    return [] if method.to_s =~ /_alerts/
  end
end
