class Item < ActiveRecord::Base
	has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  	validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  	acts_as_taggable
  	
  	has_many :order_items

  	default_scope { where(active: true) }
end
