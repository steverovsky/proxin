# encoding: utf-8
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'proxin/version'

Gem::Specification.new do |s|
  s.name         = "proxin"
  s.version      = Proxin::VERSION
  s.platform     = Gem::Platform::RUBY
  s.authors      = ["Nikita Anistratenko"]
  s.email        = ["steverovsky@gmail.com"]
  s.homepage     = "https://github.com/steverovsky/proxin"
  s.summary      = "Combine proxies with actions for checking and profiling."
  s.description  = %q{Combine proxies with actions for checking and profiling. Checking health-attributes of proxies.}

  s.license = 'MIT'

  s.add_dependency "typhoeus", "~> 1.3"

  s.files        = `git ls-files`.split("\n")
  s.test_files   = `git ls-files -- spec/*`.split("\n")
  s.require_path = 'lib'
end
