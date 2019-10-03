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
  s.summary      = "Combine proxies and actions for checking health"
  s.description  = %q{Easy way to profiling proxy. Combine proxies and actions for checking health.}

  s.license = 'MIT'

  s.files        = `git ls-files`.split("\n")
  s.test_files   = `git ls-files -- spec/*`.split("\n")
  s.require_path = 'lib'
end
