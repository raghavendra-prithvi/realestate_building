class AttachfileToListing < ActiveRecord::Migration
  create_table :attched_files do |t|
      t.string  :name
      t.integer :listing_id
    end
end
