require File.expand_path('../lib/little/version', __FILE__)

Gem::Specification.new do |s|
  s.name               = 'little'
  s.homepage           = 'http://little.io'
  s.summary            = 'A ruby client for little.io services'
  s.require_path       = 'lib'
  s.authors            = ['Karl Seguin']
  s.email              = ['help@little.io']
  s.version            = Little::VERSION
  s.platform           = Gem::Platform::RUBY
  s.files              = Dir.glob("{lib}/**/*")
  s.add_dependency('addressable', '>= 2.2.6')
  s.add_dependency('json')
end