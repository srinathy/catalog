class AddCategoryIdToVideofile < ActiveRecord::Migration
  def self.up
    add_column :videofiles, :category_id, :integer    
  end

  def self.down
    remove_column :videofiles, :category_id
  end
end
