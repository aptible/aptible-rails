class CriterionDecorator < ApplicationDecorator
  def self.overall_status(criteria)
    return 'red' if criteria.any? { |c| c.status == 'red' }
    return 'yellow' if criteria.any? { |c| c.status == 'yellow' }
    'green'
  end

  def self.status_description(status)
    case status
    when 'red' then 'Not Compliant'
    when 'green' then 'Compliant'
    when 'yellow' then 'Needs Review'
    end
  end

  def status_description
    self.class.status_description(object.status)
  end

  # rubocop:disable MethodLength
  def update_summary
    case object.scope
    when 'organization'
      if current_document
        "Updated #{h.time_ago_in_words(current_document.created_at)} ago"
      else
        'Never updated'
      end
    when 'app'
      count = unique_app_count
      "Completed for #{count} #{'app'.pluralize(count)}"
    when 'user'
      count = unique_user_count
      "Completed for #{count} #{'user'.pluralize(count)}"
    end
  end
  # rubocop:enable MethodLength

  def unique_user_count
    object.documents.map { |d| d.links['user'].href }.uniq.count
  end

  def unique_app_count
    object.documents.map { |d| d.links['app'].href }.uniq.count
  end

  def current_document
    documents.last
  end
end
