class <%= @component.component_name %>Component < AtomicAssets::Component
  def edit
    rtn = cms_fields(field_types)
    rtn << h.component(<%= ":#{@component.key}" %>), field_previews).render
    rtn.html_safe
  end

  protected

  def field_previews
    {
      header: "{{preview.header}}",
      content: markdown_preview('preview.content')
    }
  end

  def field_types
    {
      header: { field_type: "text" },
      content: { field_type: "markdown" }
    }
  end
end

