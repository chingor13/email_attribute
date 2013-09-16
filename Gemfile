source "https://rubygems.org"

# Declare your gem's dependencies in email_attribute.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# jquery-rails is used by the dummy application
gem "jquery-rails"

rails_version = ENV["RAILS_VERSION"] || "default"

rails = case rails_version
when "default"
  ">= 3.2.0"
else
  "~> #{rails_version}"
end

gem "rails", rails
