class Videofile < ActiveRecord::Base
  attr_accessible :title, :body
  
  cattr_reader :per_page
  @@per_page = 10  
  @@order = 'created_at DESC'
  
  def body=(text)
    write_attribute('body', Sanitize.clean(text, Sanitize::Config::RELAXED))
  end

end
