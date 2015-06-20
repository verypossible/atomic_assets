require 'draper'

module AtomicAssets
  class Component < Draper::Decorator
    include Serialize
    include Deserialize

    def initialize(options = {})
      super(options)
    end
  end
end
