Gem::Specification.new do |s|
  s.name        = 'atomic_assets'
  s.version     = '0.1.0'
  s.date        = '2015-06-20'
  s.summary     = 'Atomic Assets'
  s.description = 'Organize, style, and consume atomically designed assets in Ruby on Rails.'
  s.authors     = ['Don Humphreys']
  s.email       = 'dhumphreys88@gmail.com'
  s.files       = `git ls-files lib`.split("\n")
  s.homepage    = 'http://github.com/dhumphreys/atomic_assets'
  # s.license       = 'MIT'

  s.add_dependency 'draper', '~> 2.1'

  s.add_development_dependency 'rspec-core', '~> 3.3'
  s.add_development_dependency 'rspec-expectations', '~> 3.3'
  s.add_development_dependency 'rspec-mocks', '~> 3.3'
  s.add_development_dependency 'rspec-support', '~> 3.3'
end
