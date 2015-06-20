require 'bundler/setup'
Bundler.setup

require 'atomic_assets'

RSpec.configure do |config|
  # some (optional) config here
end

class TestComponent < AtomicAssets::Component
end
