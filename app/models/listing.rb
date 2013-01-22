class Listing < ActiveRecord::Base
  attr_accessible :bathrooms, :listing_type, :bedrooms, :costpersqft, :daysontapski, :laonpayment, :lotsize, :mls, :neighbourhood, :price, :squarefootage, :status, :adjustment_type, :yearbuilt
end
