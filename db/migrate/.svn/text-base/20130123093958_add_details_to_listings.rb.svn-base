class AddDetailsToListings < ActiveRecord::Migration
  def change
    add_column :listings, :description, :text
    add_column :listings, :tap_description, :text
    add_column :listings, :address_line1, :string
    add_column :listings, :address_line2, :string
    add_column :listings, :city, :string
    add_column :listings, :state, :string
    add_column :listings, :zip, :integer
  end
end
