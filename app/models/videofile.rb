class Videofile < ActiveRecord::Base
  attr_accessible :title, :body, :poster
  
  cattr_reader :per_page
  @@per_page = 12
  @@order = 'created_at DESC'
  
  def body=(text)
    write_attribute('body', Sanitize.clean(text, Sanitize::Config::RELAXED))
  end

  has_attached_file :poster, :styles => { :mainpage => "200x200" }
  validates_attachment_presence :poster
  validates_attachment_size :poster, :less_than => 5.megabyte
  validates_attachment_content_type :poster, :content_type => ['image/png', 'image/gif', 'image/jpeg']
end
