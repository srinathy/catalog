class AddVotesToVideofile < ActiveRecord::Migration
  def self.up
    add_column :videofiles, :votes, :int, :default => 0
  end

  def self.down
    remove_column :videofiles, :votes
  end
end
