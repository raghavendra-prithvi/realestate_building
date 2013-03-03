class AddnamecoloumnToUserDetails < ActiveRecord::Migration
   def change
     add_column :user_details, :first_name, :string
     add_column :user_details, :last_name, :string
     add_column :user_details, :address1, :string
     add_column :user_details, :address2, :string
     add_column :user_details, :city, :string
     add_column :user_details, :zip, :integer
   end
end
