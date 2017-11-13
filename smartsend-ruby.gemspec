lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "smartsend/version"

Gem::Specification.new do |s|
  s.name        = 'smartsend-ruby'
  s.version     = Smartsend::VERSION
  s.date        = '2017-11-13'
  s.summary     = "Smartsend.io api client"
  s.description = "Create orders in smartsend for smartsend"
  s.authors     = ["Aske Hansen"]
  s.email       = 'aske@deeco.dk'
  s.homepage    = 'https://github.com/askehansen/smartsend-ruby'
  s.license     = 'MIT'

  s.files         = `git ls-files`.split("\n")
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.add_dependency 'http', '~> 2.2'
end
