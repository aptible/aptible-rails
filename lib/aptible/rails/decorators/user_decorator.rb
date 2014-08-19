class UserDecorator < ApplicationDecorator
  def cached_organizations
    garner.bind(h.controller.cache_context) do
      object.organizations
    end
  end

  def organization_count
    garner.bind(h.controller.cache_context) do
      object.organizations.count
    end
  end

  def current_training
    training_logs.first
  end

  def training_current?
    training_logs.any?
  end

  def training_logs
    training_criterion.documents.select do |doc|
      doc.links['user'].href == object.href
    end
  end

  def training_criterion
    context[:criterion]
  end
end
