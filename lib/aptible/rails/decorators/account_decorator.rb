class AccountDecorator < ApplicationDecorator
  def needs_startup_guide?
    object.apps.count == 0 && object.databases.count == 0
  end
end
