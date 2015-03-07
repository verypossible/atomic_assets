module AtomicAssets
  module Helper
    def atom(name, options = {}, &block)
      if block_given?
        if block.arity == 0
          options[:content] = capture(&block)
        else
          block.call(options)
        end
      end
      render partial: "atoms/#{name}", locals: { options: options }
    end
  end
end
