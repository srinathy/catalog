class Videofile < ActiveRecord::Base
  attr_accessible :title, :body, :rating, :original, :poster, :category_id
  
  #paging
  cattr_reader :per_page
  @@per_page = 12
  @@order = 'created_at DESC'

  #states
  enum_attr :state, %w(^new processing active), :nil=>false
  
  belongs_to :category

  has_attached_file :poster, :styles => { :mainpage => "200x200", :small => "300x500" }, :use_timestamp => false
  validates_attachment_presence :poster
  validates_attachment_size :poster, :less_than => 5.megabyte
  validates_attachment_content_type :poster, :content_type => ['image/png', 'image/gif', 'image/jpeg']
  
  has_attached_file :original, :use_timestamp => false
  validates_attachment_presence :original
  validates_attachment_size :original, :less_than => 5.gigabyte
  validates_attachment_content_type :original, :content_type => ['video/x-msvideo', 'video/mkv', 'video/mp4', 'video/H263','video/H263-1998','video/H263-2000','video/mpeg4','video/mpeg4-generic']
  
  has_attached_file :repacked, :use_timestamp => false
  validates_attachment_content_type :repacked, :content_type => ['video/flv', 'video/x-flv', 'flv-application/octet-stream']

  def body=(text)
    write_attribute('body', Sanitize.clean(text, Sanitize::Config::RELAXED))
  end
  
 # def original=(file)
 #   self.repacked.destroy
 #   write_attribute('original', file)
 #   self.state = :new
 # end
  
  def self.convert_all
    results = self.where(:state => 'new')
    
    return if (results.count==0)
    
    results.first.process_video
  end
  
  def self.search (page, category)
    if (category)
        paginate :per_page => @@per_page, :page => page, :order => @@order, :conditions => {:category_id => category}
    else
        paginate :per_page => @@per_page, :page => page, :order => @@order
    end
  end
    
  def process_video()
    #logging of broken file should be here
    return unless (self.new?)
    
    self.state_next
    #lock record for processing
    self.save!
    
    movie = FFMPEG::Movie.new(self.original.path)
    
    #simple Paperclip::Tempfile or tempfile doesn`t work, ffmpeg and paperclip both want original file extension    
    Dir.mkdir(dir = File.join(Dir.tmpdir, rand(0x100000000000).to_s(36)))
    
    tempfile = File.join(dir, self.original.original_filename+'.flv')
    
    movie.transcode(tempfile, { 
        :video_codec => 'flv', :video_bitrate => 44100,
        :audio_bitrate => 32, :audio_sample_rate => 22050, :audio_channels => 1,
      })

    self.repacked = File.new tempfile
    self.repacked.save

    self.state_next
    self.save!
    
    FileUtils.rm_rf dir
  end

end
