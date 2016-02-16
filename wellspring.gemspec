$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "wellspring/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "wellspring"
  s.version     = Wellspring::VERSION
  s.authors     = ["Piotr Chmolowski"]
  s.email       = ["piotr@chmolowski.pl"]
  s.homepage    = "http://pchm.co/wellspring"
  s.summary     = "Summary of Wellspring."
  s.description = "Description of Wellspring."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 5.0.0.beta2"
  s.add_dependency "bcrypt", "~> 3.1.7"
  s.add_dependency "sass-rails", "~> 5.0"

  s.add_dependency "jquery-rails"
  s.add_dependency "autoprefixer-rails"
  s.add_dependency "simple_form"
  s.add_dependency "bourbon"
  s.add_dependency "neat"

  # Files & images
  s.add_dependency "dropzonejs-rails" # fancy file uploads
  s.add_dependency "carrierwave"
  s.add_dependency "mini_magick"

  s.add_dependency "redcarpet"

  s.add_development_dependency "pg"
end
