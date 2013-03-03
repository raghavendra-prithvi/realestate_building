class Listing < ActiveRecord::Base
  attr_accessible :bathrooms, :listing_type, :bedrooms, :costpersqft, :daysontapski, :laonpayment, :lotsize, :mls, :neighbourhood, :price, :squarefootage, :status, :adjustment_type, :yearbuilt,:description, :tap_description, :address_line1, :city, :address_line2, :state, :zip
  belongs_to :user

  searchable do
    text :listing_type, :name,:city,:description, :tap_description
  end
end
