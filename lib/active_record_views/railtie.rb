module ActiveRecordViews
  class Railtie < ::Rails::Railtie
    initializer 'active_record_views' do |app|
      ActiveSupport.on_load :active_record do
        ActiveRecordViews.sql_load_path << Rails.root + 'app/models'
        ActiveRecordViews.init!
      end

      ActiveSupport.on_load :action_controller do
        unless app.config.cache_classes
          ActionDispatch::Callbacks.before do
            ActiveRecordViews.reload_stale_views!
          end
        end
      end
    end
  end
end
