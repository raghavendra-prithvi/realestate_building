class AddUserIdToSaveSearch < ActiveRecord::Migration
  def change
    add_column :search, :user_id, :integer
    add_column :search, :max_amount, :integer
    add_column :search, :min_amount, :integer
    add_column :search, :days_before, :integer
    add_column :search, :name, :string
  end
end
