class AddOriginalToVideofile < ActiveRecord::Migration
  def self.up
    add_column :videofiles, :original_file_name, :string
    add_column :videofiles, :original_content_type, :string
    add_column :videofiles, :original_file_size, :integer
    add_column :videofiles, :original_updated_at,   :datetime        
  end

  def self.down
    remove_column :videofiles, :original_file_size
    remove_column :videofiles, :original_content_type
    remove_column :videofiles, :original_file_name
    remove_column :videofiles, :original_updated_at        
  end
end
