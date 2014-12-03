# TODO: Refactor into OperableDecorator module
class ResourceDecorator < ApplicationDecorator
  def last_operation_gravatar
    garner.bind(h.controller.session_token).bind(object) do
      last_operation.creator_gravatar
    end
  end

  def last_operation_summary
    garner.bind(h.controller.session_token).bind(object) do
      "#{last_operation.past_tense} " \
      "#{h.time_ago_in_words(last_operation.created_at)} ago"
    end
  end

  def last_operation
    return nil unless object.last_operation
    @last_operation ||= OperationDecorator.decorate(object.last_operation)
  end
end
