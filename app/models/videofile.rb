class Videofile < ActiveRecord::Base
  attr_accessible :title, :body, :rating
  
  cattr_reader :per_page
  @@per_page = 12
  @@order = 'created_at DESC'

  has_attached_file :poster, :styles => { :mainpage => "200x200" }, :use_timestamp => false
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
  
  def original=(file)
    self.repacked.destroy
    write_attribute('repacked', file)
  end
  
  def self.convert_all
  end
  
  def process_video()
    if (!self.repacked.present?)
      #logging of broken file should be here
      return
    end
    
    movie = FFMPEG::Movie.new(self.original.path)
    
    #simple Paperclip::Tempfile or tempfile doesn`t work, ffmpeg and paperclip both want original file extension    
    Dir.mkdir(dir = File.join(Dir.tmpdir, rand(0x100000000000).to_s(36)))
    
    tempfile = File.join(dir, self.original.original_filename)
    
    movie.transcode(tempfile, { :video_codec => 'flv', :video_bitrate => 22500, :audio_channels => 1})

    self.repacked = File.new tempfile
    self.repacked.save
    
    FileUtils.rm_rf dir
  end

end
