class Category < ActiveRecord::Base
  attr_accessible :title, :parent_id
  has_ancestry
  
  #from https://github.com/stefankroes/ancestry/wiki/Creating-a-selectbox-for-a-form-using-ancestry
  def self.input_list
    self.all.each { |c| c.ancestry = c.ancestry.to_s + (c.ancestry != nil ? "/" : '') + c.id.to_s 
      }.sort {|x,y| x.ancestry <=> y.ancestry 
      }.map{ |c| ["-" * (c.depth - 1) + c.title,c.id] 
      }.unshift(["-- none --", nil])
  end
  
  def self.get_subcats(id)
    if (!id)
      roots
    else
      find(id).children
    end
  end
end
