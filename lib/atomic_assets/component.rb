require 'draper'

module AtomicAssets
  class Component < Draper::Decorator
    include Deserialize
    include Helper
    include Initialize
    include Render
    include Serialize
  end
end
