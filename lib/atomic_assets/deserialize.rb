require 'yaml'

module AtomicAssets
  module Deserialize
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def from_hash(params)
        obj = params.delete(:template_name).constantize.new
        params.each { |key, val| obj.send("#{key}=", from_value(key, val)) }
        obj
      end

      def from_yaml(yaml_string)
        preload_components(yaml_string)
        YAML.load(yaml_string)
      end

      private

      def from_array(hash)
        array = []
        hash.each do |key,element|
          array << from_hash(element)
        end
        array
      end

      def from_value(key, value)
        return from_array(value) if key === 'children'
        return from_hash(value) if Hash === value
        value
      end

      def preload_components(yaml_string)
        yaml_string.scan(/(?<=\!ruby\/object:)\w+/).uniq.map(&:constantize)
      end
    end
  end
end