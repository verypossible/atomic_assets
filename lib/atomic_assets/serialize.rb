require 'yaml'

module AtomicAssets
  module Serialize
    def to_yaml
      YAML.dump(self)
    end
  end
end