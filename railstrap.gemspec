$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "railstrap/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "railstrap"
  s.version     = Railstrap::VERSION
  s.authors     = ["Christian Rost"]
  s.email       = ["chr@baltic-online.de"]
  s.summary     = "Generic helper for bootstrap/kickstrap."
  s.description = "Generic helper for bootstrap/kickstrap."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  %w{ activesupport actionpack railties }.each do |gem|
    s.add_dependency gem, ['>= 3.0.0']
  end
  s.add_dependency "haml"
  %w{ activerecord actionmailer sqlite3 }.each do |gem|
    s.add_development_dependency gem
  end
end
