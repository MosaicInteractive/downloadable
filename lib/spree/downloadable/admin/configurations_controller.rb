module Spree::Downloadable::Admin::ConfigurationsController
  def self.included(target)
    target.class_eval do
       # Add Global/General Settings for all product downloads
      before_filter :add_product_download_settings_links, :only => :index

      def add_product_download_settings_links
        @extension_links << {:link => admin_downloadable_settings_path, :link_text => t('downloadable_settings'),
          :description => "Configure general product download settings."}
      end
    end
  end
end
