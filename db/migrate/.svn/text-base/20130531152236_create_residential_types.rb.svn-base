class CreateResidentialTypes < ActiveRecord::Migration
  def self.up
    create_table :residential_types do |t|
      t.string  :name
    end

    ResidentialType.create :name => "Single Family Home (Detached)"
    ResidentialType.create :name => "Single Family Home (Attached)"
    ResidentialType.create :name => "Apartment"
    ResidentialType.create :name => "Condominium"
  end

  def self.down
    drop_table :residential_types
  end
  
end
