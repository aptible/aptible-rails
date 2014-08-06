class AppDecorator < ResourceDecorator
  def interviews
    @interviews ||= Interview.by_version.where(app_href: object.href)
  end

  def compliant?
    return false unless interviews.any?

    time_since_last = Time.now - interviews.first.effective_date
    return true if time_since_last <= security_criterion.default_expiry
  end

  def current_interview
    @current_interview ||= interviews.first
  end

  def service_summary
    garner.bind(h.controller.session_token).bind(object) do
      object.services.map(&:process_type).join(', ')
    end
  end

  def security_criterion
    context[:criterion]
  end
end
