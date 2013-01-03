# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'guard/phpunit/version'

Gem::Specification.new do |s|
  s.name        = "guard-phpunit-sf2"
  s.version     = Guard::PHPUnitVersion::VERSION
  s.authors     = ["Giulio De Donato", "Maher Sallam"]
  s.email       = ["liuggio@gmail.com", "maher@sallam.me"]
  s.homepage    = ""
  s.summary     = %q{Guard gem for PHPUnit and Symfony2}
  s.description = %q{Guard::PHPUnit automatically run your unit-tests written with the PHPUnit testing framework with Symfony2.}

  s.required_rubygems_version = '>= 1.3.6'
  s.rubyforge_project = 'guard-phpunit-sf2'

  s.add_runtime_dependency 'guard', '~> 1.1'

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'yard'
  s.add_development_dependency 'redcarpet'
  s.add_development_dependency 'pimpmychangelog'

  s.files         = `git ls-files -- lib/*`.split("\n") + Dir.glob('{lib}/**/PHPUnit/**/*') + %w[LICENSE README.md CHANGELOG.md]
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]
end
