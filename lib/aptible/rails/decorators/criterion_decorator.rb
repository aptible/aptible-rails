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

  def update_summary
    if current_document
      "Updated #{h.time_ago_in_words(current_document.created_at)} ago"
    else
      'Never updated'
    end
  end

  def current_document
    documents.first
  end
end
