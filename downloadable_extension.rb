#require_dependency 'application'
#require_dependency 'application_controller'

class DownloadableExtension < Spree::Extension
  version "1.1"
  description "Downloadable products"
  url "http://github.com/mosaic/downloadable"
  
  def self.require_gems(config)
    config.gem 'rubyzip', :lib => 'zip/zip', :version => '0.9.4'
  end
  
  def activate
    # Need a global peference for download limits
    AppConfiguration.send(:include, Spree::Downloadable::AppConfiguration)
    
    # Add Global/General Settings for all product downloads
    Admin::ConfigurationsController.send(:include, Spree::Downloadable::Admin::ConfigurationsController)
    
    #Admin::BaseController.class_eval do 
    #  before_filter :add_product_admin_tabs
    #  
    #  # Insert downloadable link to admin product tabs
    #  def add_product_admin_tabs
    #    @product_admin_tabs << {:name => "Downloadables", :url => "admin_product_downloadables_url"}
    #  end
    #end
    
    # ----------------------------------------------------------------------------------------------------------
    # Model class_evals 
    # ----------------------------------------------------------------------------------------------------------
    
    Product.send(:include, Spree::Downloadable::Product)
    
    Variant.send(:include, Spree::Downloadable::Variant)
    
    
    LineItem.send(:include, Spree::Downloadable::LineItem)
    
    OrderMailer.send(:include, Spree::Downloadable::OrderMailer)
    
    # ----------------------------------------------------------------------------------------------------------
    # End for Models
    # ----------------------------------------------------------------------------------------------------------
    
    # ----------------------------------------------------------------------------------------------------------
    # Helper class_evals
    # ----------------------------------------------------------------------------------------------------------
    ApplicationHelper.send(:include, Spree::Downloadable::ApplicationHelper)
    # ----------------------------------------------------------------------------------------------------------
    # End for Helpers 
    # ----------------------------------------------------------------------------------------------------------   

    # ----------------------------------------------------------------------------------------------------------
    # Configure Paperclip
    # ----------------------------------------------------------------------------------------------------------   
    Paperclip.interpolates(:secret) do |attachment, style|
      Digest::MD5.hexdigest("#{attachment.instance.id}-#{ActionController::Base.session_options[:secret]}")
    end
    # ----------------------------------------------------------------------------------------------------------
    # End for Paperclip Configuration
    # ----------------------------------------------------------------------------------------------------------   
  
  end
end
