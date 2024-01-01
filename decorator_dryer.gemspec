# frozen_string_literal: true

require_relative "lib/decorator_dryer/version"

Gem::Specification.new do |s|
  s.name = "decorator_dryer"
  s.version = DecoratorDryer::VERSION
  s.authors = ["Mark Harbison"]
  s.email = ["mark@tyne-solutions.com"]

  s.summary = "Shortcuts for concise view models."
  s.description = "Shortcuts for concise view models."
  s.homepage = "https://github.com/CodeTectonics/decorator_dryer"
  s.license = "MIT"
  s.required_ruby_version = ">= 2.6.0"

  s.metadata["homepage_uri"]    = s.homepage
  s.metadata["source_code_uri"] = s.homepage
  s.metadata["changelog_uri"]   = "#{s.homepage}/blob/main/CHANGELOG.md"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- spec/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_development_dependency "rake", "~> 13.0"
  s.add_development_dependency "rspec", "~> 3.12"
  s.add_development_dependency "rubocop", "~> 1.7"
end
