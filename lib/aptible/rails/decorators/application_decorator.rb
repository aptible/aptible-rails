require 'garner'

class ApplicationDecorator < Draper::Decorator
  include Garner::Cache::Context

  delegate_all
end
