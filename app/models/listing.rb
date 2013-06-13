class Listing < ActiveRecord::Base
    has_many :pictures
    acts_as_votable
  attr_accessible :bathrooms, :name,:listing_type, :bedrooms, :costpersqft, :daysontapski, :laonpayment, :lotsize, :mls, :neighbourhood, :price, :squarefootage, :status, :adjustment_type, :yearbuilt,:description, :tap_description, :address_line1, :city, :address_line2, :state, :zip,:image_file,:lat, :long
  belongs_to :user

  def self.search(keyword)
    where('name ilike :keyword OR description ilike :keyword OR tap_description ilike :keyword', { :keyword => "%#{keyword}%" })
  end
end
