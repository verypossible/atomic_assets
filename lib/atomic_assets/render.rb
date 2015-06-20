module AtomicAssets
  module Render
    COMPONENT_PATH = 'components'

    def render
      h.render(template: template_path, locals: object)
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
