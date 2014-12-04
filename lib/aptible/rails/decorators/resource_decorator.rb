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
    return @last_operation if @last_operation
    if object.respond_to?(:last_operation)
      operation = object.last_operation
    else
      operation = object.operations.last
    end

    return nil unless operation
    @last_operation = OperationDecorator.decorate(operation)
  end

  def operation_count
    garner.bind(h.controller.session_token).bind(object) do
      object.operations.count
    end
  end
end
