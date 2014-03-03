require 'aptible/rails/controller'

module Aptible
  module Rails
    class Railtie < ::Rails::Railtie
      initializer 'fridge.configure' do
        require 'fridge'
        require 'aptible/auth'

        Fridge.configure do |config|
          config.public_key = Aptible::Auth.public_key unless ::Rails.env.test?
        end
      end

      initializer 'aptible.rails.controller' do
        ActionController::Base.send :include, Aptible::Rails::Controller
      end
    end
  end
end
