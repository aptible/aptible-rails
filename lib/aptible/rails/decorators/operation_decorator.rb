class OperationDecorator < ApplicationDecorator
  def past_tense
    object.type.humanize + (type[-1] == 'e' ? 'd' : 'ed')
  end

  def gravatar
    garner.bind(h.controller.session_token).bind(object) do
      return nil if object.user.nil? && object.user_email.nil?
      email = object.user_email || object.user.email
      h.gravatar_url(email, 32)
    end
  end

  def creator_name
    garner.bind(h.controller.session_token).bind(object) do
      return nil if object.user.nil? && object.user_name.nil?
      object.user_name || object.user.name
    end
  end
end
