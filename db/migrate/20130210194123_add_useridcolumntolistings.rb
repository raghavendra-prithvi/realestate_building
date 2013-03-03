class AddUseridcolumntolistings < ActiveRecord::Migration
  def change
         add_column :listings, :user_id, :integer
  end

end
