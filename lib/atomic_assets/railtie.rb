module AtomicAssets
  class Railtie < Rails::Railtie
    config.after_initialize do |app|
      app.config.autoload_paths << 'app/components'
    end

    initializer "atomic_assets.setup_action_controller" do |app|
      ActiveSupport.on_load :action_controller do
        include AtomicAssets::Helper
      end
    end

    initializer "atomic_assets.setup_action_view" do |app|
      ActiveSupport.on_load :action_view do
        include AtomicAssets::Helper
      end
    end
  end
end