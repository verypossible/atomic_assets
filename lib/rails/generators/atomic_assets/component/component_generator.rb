module AtomicAssets
  module Generators
    class ComponentGenerator < Rails::Generators::Base
      argument :component_name, required: true

      desc <<-DESC.strip_heredoc
        Creates all files requred when generating a new atomic asset component
      DESC

      source_root File.expand_path("../../templates", __FILE__)

      def create_component_file
        @component = OpenStruct.new(
          class_prefix: class_prefix,
          key: file_prefix
        )
        template "component.rb", "app/components/#{file_prefix}_component.rb"
      end

      def create_scss_file
        fullpath = "app/assets/stylesheets/components/_#{file_prefix}.scss"
        template "component.scss", fullpath
      end

      def create_slim_file
        fullpath = "app/views/components/#{file_prefix}.html.slim"
        template "component.slim", fullpath
      end

      private

      def file_prefix
        component_name.underscore
      end

      def class_prefix
        component_name.camelize
      end
    end
  end
end
