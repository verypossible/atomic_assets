require 'draper'

module AtomicAssets
  class Component
    include Draper::ViewHelpers

    include Deserialize
    include Helper
    include Initialize
    include Options
    include Render
    include Serialize

    attr_accessor :options
  end
end
