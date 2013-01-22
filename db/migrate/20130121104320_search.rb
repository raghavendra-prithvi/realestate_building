class Search < ActiveRecord::Migration
def change
    create_table :search do |t|

    t.string :type
    t.integer :pricerange
    t.integer :beds
    t.integer :bath
    t.integer :keywords
    t.integer :zip
    t.string :propertytype
    t.integer :tapratings
    t.boolean :wanted
    t.string :email
    t.integer :agent_id
  end
end
end