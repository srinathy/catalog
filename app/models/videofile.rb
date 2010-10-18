class Videofile < ActiveRecord::Base
  cattr_reader :per_page
  @@per_page = 10  
  @@order = 'created_at DESC'
end
