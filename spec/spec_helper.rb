require 'bundler/setup'
Bundler.setup

require 'atomic_assets'

RSpec.configure do |config|
  # some (optional) config here
end

class TestComponent < AtomicAssets::Component
end

class OptionComponent < AtomicAssets::Component
  option :one, a: 1, b: 2
  option :three, c: 5
end
