require 'yaml'

module AtomicAssets
  module Deserialize
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def from_yaml(yaml_string)
        preload_components(yaml_string)
        YAML.load(yaml_string)
      end

      private

      def preload_components(yaml_string)
        yaml_string.scan(/(?<=\!ruby\/object:)\w+/).uniq.map(&:constantize)
      end
    end
  end
end