class AdduidcoloumnToUserDetails < ActiveRecord::Migration
   def change
   add_column :user_details, :uid, :string

end
end
