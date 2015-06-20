require 'draper'

module AtomicAssets
  class Component < Draper::Decorator
    include Initialize

    include Deserialize
    include Serialize
  end
end
