$:.push File.expand_path("../lib", __FILE__)
require 'omniauth/snapchat/version'

Gem::Specification.new do |s|
  s.name          = 'omniauth-snapchat-publisher'
  s.version       = Omniauth::Snapchat::VERSION
  s.date          = '2020-04-20'
  s.authors       = ['Patrycja Strugala']
  s.email         = 'patrycja.strugala@paladinsoftware.com'
  s.summary       = 'OmniAuth Strategy for Snapchat'
  s.homepage      = "https://github.com/paladinsoftware/omniauth-snapchat-publisher"
  s.files         = `git ls-files`.split("\n")
  s.require_paths = ['lib']

  s.add_runtime_dependency "omniauth-oauth2", "~> 1.2"
end
