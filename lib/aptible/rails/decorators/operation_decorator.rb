class OperationDecorator < ApplicationDecorator
  def past_tense
    object.type.humanize + (type[-1] == 'e' ? 'd' : 'ed')
  end
end
