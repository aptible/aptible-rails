require 'garner'

class ApplicationDecorator < Draper::Decorator
  include Garner::Cache::Context

  delegate_all
end

require_relative 'resource_decorator'
require_relative 'criterion_decorator'
require_relative 'account_decorator'
require_relative 'app_decorator'
require_relative 'database_decorator'
require_relative 'operation_decorator'
require_relative 'organization_decorator'
require_relative 'user_decorator'
