require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module InstaFollow
  class Application < Rails::Application

    config.autoload_paths += Dir["#{Rails.root}/lib"]

    Capybara::Webkit.configure do |config|
      config.allow_unknown_urls
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
