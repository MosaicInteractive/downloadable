module Spree::Downloadable::Variant
  def self.included(target)
    target.class_eval do
      # Add downloadables to variants
      has_many :downloadables, :as => :viewable, :order => :position, :dependent => :destroy
    end
  end
end
