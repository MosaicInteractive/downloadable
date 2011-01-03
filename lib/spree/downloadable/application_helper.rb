module Spree::Downloadable::ApplicationHelper
  def self.included(target)
    target.class_eval do
      # Checks if checkout cart has ONLY downloadable items
      # Used for shipping in helpers/checkouts_helper.rb
      def only_downloadable
        downloadable_count = 0
        @order.line_items.each do |item|
          if((!item.product.downloadables.empty?) || (!item.variant.downloadables.empty?))
            downloadable_count += 1
          end
        end
        @order.line_items.size == downloadable_count
      end

      def has_downloadable?
        @order.line_items.each do |item|
          return true if ((!item.product.downloadables.empty?) || (!item.variant.downloadables.empty?))
        end
      end

      def render_links(item, options={:html => true})
        if options[:html] == false
          return t(:download) + ': ' + downloadable_url(item, :s => generate_secret(item))
        elsif !item.variant.downloadables.empty?
          return content_tag(:sub,t(:download) + ': ' + link_to("#{item.variant.downloadables.first.filename}", downloadable_url(item, :s => generate_secret(item))))
        elsif !item.product.downloadables.empty?
          return content_tag(:sub,t(:download) + ': ' + link_to("#{item.product.downloadables.first.filename}", downloadable_url(item, :s => generate_secret(item))))
        end
      end

      def generate_secret(record)
        Digest::MD5.hexdigest("#{record.id}-#{ActionController::Base.session_options[:secret]}")
      end
    end
  end
end
