class AddRatingToVideofile < ActiveRecord::Migration
  def self.up
    add_column :videofiles, :rating, :int, :default => 0
  end

  def self.down
    remove_column :videofiles, :rating
  end
end
