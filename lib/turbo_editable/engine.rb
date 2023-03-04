require 'rubygems'
require 'rails'

module TurboEditable
  module Rails
    class Engine < ::Rails::Engine
      initializer 'turbo_editable.assets' do |app|
        %w(stylesheets javascripts).each do |sub|
          app.config.assets.paths << root.join('assets', sub).to_s
        end
      end
    end
  end
end
