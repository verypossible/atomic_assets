module AtomicAssets
  module Options
    def self.included(base)
      base.extend(ClassMethods)
      base.class_attribute :option_settings
      base.option_settings = {}
    end

    module ClassMethods
      def option(name, settings = {})
        self.option_settings = self.option_settings.merge(
          name.to_sym => settings
        )

        define_method(name) do
          self.options[name]
        end
      end

      def option_keys
        option_settings.keys
      end
    end
  end
end
