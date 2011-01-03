module Spree::Downloadable::Product
  def self.included(target)
    target.class_eval do
      # Add downloadables to products
      has_many :downloadables, :as => :viewable, :order => :position, :dependent => :destroy
    end
  end
end
