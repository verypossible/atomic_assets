require 'atomic_assets/deserialize'
require 'atomic_assets/helper'
require 'atomic_assets/initialize'
require 'atomic_assets/render'
require 'atomic_assets/serialize'

require 'atomic_assets/component'

module ApplicationHelper
  include AtomicAssets::Helper
end
