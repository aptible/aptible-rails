# TODO: Refactor into OperableDecorator module
class ResourceDecorator < ApplicationDecorator
  def last_operation_gravatar
    garner.bind(h.controller.session_token).bind(object) do
      unless last_operation.user.nil?
        h.gravatar_url(last_operation.user.email, 32)
      end
    end
  end

  def last_operation_summary
    garner.bind(h.controller.session_token).bind(object) do
      "#{last_operation.decorate.past_tense} " \
      "#{h.time_ago_in_words(last_operation.created_at)} ago"
    end
  end

  def last_operation
    object.operations.first
  end

  def operation_count
    garner.bind(h.controller.session_token).bind(object) do
      object.operations.count
    end
  end
end
