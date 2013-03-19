class SaveDataToPicture < ActiveRecord::Migration
  def change
    add_column :pictures, :upload_file_name, :string
    add_column :pictures, :upload_content_type, :string
    add_column :pictures, :upload_file_size, :integer
    add_column :pictures, :data, :binary
  end
end
