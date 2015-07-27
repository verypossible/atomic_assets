module AtomicAssets
  module Render
    COMPONENT_PATH = 'components'
    PARTIALS_DEPRECATED = 'Using view partial component templates will be removed in atomic_assets-0.1.0. Please remove leading underscores from your template file names.'

    # keep rails from escaping object output
    def html_safe?
      true
    end

    def render
      render_template
    rescue ActionView::MissingTemplate => error
      raise error unless error.path == component_name
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

    def default_options
      self.class.option_keys.map do |key|
        [key, nil]
      end.to_h
    end

    def local_options
      opts = render_options
      opts.merge(options: opts)
    end

    def render_options
      default_options.merge(options)
    end

    def render_partial
      output = h.render(partial: template_path, locals: local_options, formats: [:html])
      ActiveSupport::Deprecation.warn(PARTIALS_DEPRECATED)
      output
    end

    def render_template
      h.render(template: template_path, locals: local_options, formats: [:html])
    end
  end
end
