class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.integer :listing_id
      t.text :description
      t.string :file_name
      t.string :file_path

      t.timestamps
    end
  end
end
