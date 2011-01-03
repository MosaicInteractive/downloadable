module Spree::Downloadable::LineItem
  def self.included(target)
    target.class_eval do
      before_create :add_download_limit

      # Insert download limit to line items for orders
      def add_download_limit
        use_global = false

        if !self.variant.nil? and !self.variant.downloadables.empty?
          if self.variant.downloadables.first.download_limit.nil?
            use_global = true
          else
            self.download_limit = self.variant.downloadables.first.download_limit
          end
        elsif !self.variant.product.nil? and !self.variant.product.downloadables.empty?
          if self.variant.product.downloadables.first.download_limit.nil?
            use_global = true
          else
            self.download_limit = self.variant.product.downloadables.first.download_limit
          end
        end

        if((Spree::Config[:download_limit] != 0) && use_global)
          self.download_limit = Spree::Config[:download_limit]
        end
      end
    end
  end
end
