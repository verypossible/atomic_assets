module AtomicAssets
  module Render
    COMPONENT_PATH = 'components'

    def render
      h.render(partial: template_path, locals: { options: options })
    end

    def to_s
      render
    end

    private

    def component_name
      self.class.name.underscore.gsub(/_component$/, '')
    end

    def template_path
      File.join(COMPONENT_PATH, component_name)
    end
  end
end
