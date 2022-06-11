require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Bookers2
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    # config.time_zone = "Central Time (US & Canada)"
    config.time_zone = 'Asia/Tokyo' #タイムゾーンを日本語に設定
    config.i18n.default_locale = :ja #投稿時間表示のため？(config/locales/ja.yml)と繋がっている？
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
