$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "audit_trails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "audit_trails"
  s.version     = AuditTrails::VERSION
  s.authors     = ["Sachin Choudhary, Rajeev Kannav Sharma"]
  s.email       = ["rajeev@headerlabs.com"]
  s.homepage    = "https://github.com/rajeevkannav/audit_trails"
  s.summary     = "Summary of AuditTrails."
  s.description = "Description of AuditTrails."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.2"

  s.add_development_dependency "sqlite3"
end


