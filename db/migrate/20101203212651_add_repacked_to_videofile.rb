class AddRepackedToVideofile < ActiveRecord::Migration
  def self.up
    add_column :videofiles, :repacked_file_name, :string
    add_column :videofiles, :repacked_content_type, :string
    add_column :videofiles, :repacked_file_size, :integer
    add_column :videofiles, :repacked_updated_at,   :datetime    
  end

  def self.down
    remove_column :videofiles, :repacked_file_size
    remove_column :videofiles, :repacked_content_type
    remove_column :videofiles, :repacked_file_name
    remove_column :videofiles, :repacked_updated_at    
  end
end
