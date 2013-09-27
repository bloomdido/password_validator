$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "password_validator/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "password_validator"
  s.version     = PasswordValidator::VERSION
  s.authors     = ["Chris Anthes"]
  s.email       = ["canthes@bloomdido.com"]
  s.homepage    = "https://github.com/bloomdido/password_validator"
  s.summary     = "An ActiveModel validator that consolidates multiple password validations."
  s.licenses    = ["MIT"]

  s.files = Dir["lib/*.rb"]
  s.test_files = Dir["test/**/*"]
  s.require_paths = ["lib"]

  s.add_runtime_dependency "activemodel"
end
