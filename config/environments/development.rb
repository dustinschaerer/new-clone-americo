 Americo::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = true

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = false

  # Add mailer config options for Devise
  #config.action_mailer.default_url_options = { :host => 'localhost:3000' }
  config.action_mailer.default_url_options = { :host => 'www.americo-inc.com' }

  # Set email delivery configuration
  config.action_mailer.delivery_method = :smtp

  # Action Mailer config setting
#  config.action_mailer.smtp_settings = {
#    address:    "smtp.gmail.com",
#    port:       587,
#    domain:     "americo-test.us",
#    authentication: "plain",
#    user_name:  "dustinschaerer@gmail.com",
#    password:   "oldpwd",
#    enable_starttls_auto: true
#  }

  # Action Mailer config setting
  config.action_mailer.smtp_settings = {
    address:    'smtp.mandrillapp.com',
    port:       '587',
    domain:     'heroku.com',
    authentication: 'plain',
    user_name:  ENV['MANDRILL_USERNAME'],
    password:   ENV['MANDRILL_APIKEY'],
    enable_starttls_auto: true
  }

  config.after_initialize do
    ActiveMerchant::Billing::Base.mode = :test
    Bullet.enable = false
    Bullet.alert = false
    Bullet.bullet_logger = false
    Bullet.console = false
    Bullet.rails_logger = false
    Bullet.add_footer = false
  end

  config.assets.raise_production_errors = true

end
