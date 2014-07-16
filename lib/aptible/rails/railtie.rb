require 'aptible/rails/controller'
require 'aptible/rails/url_helper'
require 'aptible/rails/view_helper'

module Aptible
  module Rails
    class Railtie < ::Rails::Railtie
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
