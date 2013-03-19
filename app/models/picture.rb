class Picture < ActiveRecord::Base
  attr_accessible :image_file
  belongs_to :user
  belongs_to :listing

#  searchable do
#    text :listing_type, :name,:city,:description, :tap_description
#  end
end
