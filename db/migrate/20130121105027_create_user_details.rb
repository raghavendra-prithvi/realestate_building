class CreateUserDetails < ActiveRecord::Migration
  def change
    create_table :user_details do |t|
      t.integer :picture_id
      t.boolean :profile_public
      t.string :full_name
      t.text :full_address
      t.integer :phone
      t.string :email
      t.string :updated_by
      t.timestamps
    end
  end
end
