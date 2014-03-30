require 'aptible/rails/controller'
require 'aptible/rails/routes_helper'

module Aptible
  module Rails
    class Railtie < ::Rails::Railtie
      initializer 'fridge.configure' do
        require 'fridge'
        require 'aptible/auth'

        Fridge.configure do |config|
          begin
            unless ::Rails.env.test?
              config.public_key = Aptible::Auth.public_key
            end
          rescue
            raise 'Could not retrieve auth server public key'
          end
        end
      end

      initializer 'aptible.rails.controller' do
        ActionController::Base.send :include, Aptible::Rails::Controller
      end

      initializer 'aptible.rails.routes_helper' do
        ApplicationHelper.send :include, Aptible::Rails::RoutesHelper
      end
    end
  end
end
