require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Americo
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.assets.initialize_on_precompile = true

    config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif *.woff *.eot *.svg *.ttf application.js application.css admin.js admin.css)

    config.i18n.enforce_available_locales = false

    I18n.enforce_available_locales = true

    config.autoload_paths += %W(#{config.root}/lib)

    config.filter_parameters += [:password, :password_confirmation]

    config. generators do |g|
        g.test_framework :test_unit
    end

    config.assets.enabled = true
    config.filter_parameters << :card_number << :card_verification

    config.assets.paths << "#{Rails.root}/app/themes/default/"
    config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
    config.assets.paths << "#{Rails.root}/vendor/assets/fonts"

  end
end
