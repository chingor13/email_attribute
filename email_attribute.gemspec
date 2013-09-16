$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "email_attribute/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "email_attribute"
  s.version     = EmailAttribute::VERSION
  s.authors     = ["Jeff Ching"]
  s.email       = ["ching.jeff@gmail.com"]
  s.homepage    = "http://github.com/chingor13/email_attribute"
  s.summary     = "ActiveModel field serializer for handling email addresses via Mail gem"
  s.description = "ActiveModel field serializer for handling email addresses via Mail gem"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 3.2.0"
  s.add_dependency "mail", "~> 2.5.0"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "shoulda-context"
end
