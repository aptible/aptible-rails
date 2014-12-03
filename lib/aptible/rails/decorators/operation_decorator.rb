class OperationDecorator < ApplicationDecorator
  # TODO: cleanup after manual migration of user data to operations

  def past_tense
    object.type.humanize + (object.type[-1] == 'e' ? 'd' : 'ed')
  end

  def creator_gravatar
    return nil if object.user.nil? && object.user_email.nil?
    email = object.user_email || object.user.email
    h.gravatar_url(email, 32)
  end

  def creator_name
    return nil if object.user.nil? && object.user_name.nil?
    object.user_name || object.user.name
  end
end
