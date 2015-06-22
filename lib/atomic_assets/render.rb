module AtomicAssets
  module Render
    COMPONENT_PATH = 'components'
    PARTIALS_DEPRECATED = 'Using view partial component templates will be removed in atomic_assets-0.1.0. Please remove leading underscores from your template file names.'

    def render
      render_template
    rescue ActionView::MissingTemplate => error
      raise error unless error.path == template_path
      render_partial
    end

    def template_path
      File.join(COMPONENT_PATH, component_name)
    end

    def to_s
      render
    end

    private

    def component_name
      self.class.name.underscore.gsub(/_component$/, '')
    end

    def local_options
      options.merge(options: options)
    end

    def render_partial
      output = h.render(partial: template_path, locals: local_options)
      ActiveSupport::Deprecation.warn(PARTIALS_DEPRECATED)
      output
    end

    def render_template
      h.render(template: template_path, locals: local_options)
    end
  end
end
