class AddTimestampsToSearch < ActiveRecord::Migration
  def change
      add_column(:search, :created_at, :datetime)
      add_column(:search, :updated_at, :datetime)
  end
end
