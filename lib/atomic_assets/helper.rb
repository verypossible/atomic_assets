module AtomicAssets
  module Helper
    def component(name, options = {}, &block)
      component_class(name).new(options, &block)
    end

    private

    def build_component_class(name)
      klass = Class.new(AtomicAssets::Component)
      Object.const_set(name, klass)
    end

    def component_class(name)
      klass = "#{name}_component".classify
      klass.constantize
    rescue NameError
      build_component_class(klass)
    end
  end
end
