class CreateVideofiles < ActiveRecord::Migration
  def self.up
    create_table :videofiles do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end

  def self.down
    drop_table :videofiles
  end
end
