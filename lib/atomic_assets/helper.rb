module AtomicAssets
  module Helper
    def component(name, options = {}, &block)
      component_class(name).new(options, &block)
    end

    private

    def component_class(name)
      "#{name}_component".classify.constantize
    end
  end
end
