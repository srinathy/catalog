class AddStateToVideofile < ActiveRecord::Migration
  def self.up
    add_column :videofiles, :state, :string    
  end

  def self.down
    remove_column :videofiles, :state
  end
end
