require 'aptible/rails/controller'
require 'aptible/rails/url_helper'
require 'aptible/rails/view_helper'
require 'aptible/rails/array_extensions'
require 'aptible/rails/draper_extensions'
require 'aptible/rails/garner'

require 'draper'
require 'aptible/rails/decorators/application_decorator'

Dir["#{File.dirname(__FILE__)}/models/**/*.rb"].each do |file|
  require file
end

module Aptible
  module Rails
    class Railtie < ::Rails::Railtie
      initializer 'aptible.rails.draper' do
        Array.send :include, Aptible::Rails::ArrayExtensions
        Aptible::Resource::Base.send :include, Aptible::Rails::DraperExtensions
      end

      initializer 'aptible.rails.controller' do
        ActionController::Base.send :include, Aptible::Rails::Controller
      end

      initializer 'aptible.rails.routes_helper' do
        ActionController::Base.send :include, Aptible::Rails::UrlHelper
      end

      initializer 'aptible.rails.view_helpers' do
        ActionView::Base.send :include, Aptible::Rails::ViewHelpers
      end
    end
  end
end
