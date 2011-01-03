module Spree::Downloadable::AppConfiguration
  def self.included(base)
    base.class_eval do
      # Add global download_limit preference
      preference :download_limit, :integer, :default => 0 # 0 for unlimited
    end
  end
end
