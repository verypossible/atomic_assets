module AtomicAssets
  module Initialize
    def initialize(options = {}, &block)
      raise ArgumentError unless options.is_a? Hash
      capture_block(options, &block) if block_given?
      super(options)
    end

    private

    def capture_block(options, &block)
      options.merge!(content: h.capture(&block))
    end
  end
end