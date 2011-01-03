module Spree::Downloadable::OrderMailer
  def self.included(target)
    target.class_eval do
      # For render_links
      helper :application

      # For url_for :host
      default_url_options[:host] = Spree::Config[:site_url]
    end
  end
end
