require 'spec_helper'

describe Videofile do
  before(:each) do
    @file = Factory.stub :videofile
  end
  
  #we don't test sanitize, but do test if it is present
  it "should be xss-proof" do
    
    test = '<SCRIPT SRC=http://ha.ckers.org/xss.js></SCRIPT>'
    @file.body = test
    @file.body.should_not == test
  end
  
  it { should have_attached_file(:poster) }
  it { should validate_attachment_presence(:poster) }
    
  it { should validate_attachment_content_type(:poster).
     allowing('image/png', 'image/gif', 'image/jpeg').
     rejecting('text/plain', 'text/xml', 'video/x-msvideo') 
  }
  
  it { should have_attached_file(:original) }
  it { should validate_attachment_presence(:original) }
  
  it { should validate_attachment_content_type(:original).
       allowing('video/x-msvideo', 'video/mkv', 'video/mp4').
       rejecting('text/plain', 'text/xml', 'text/html')}
  
  it { should have_attached_file(:repacked) }
  it { should validate_attachment_content_type(:repacked).
      allowing('video/flv', 'video/x-flv', 'flv-application/octet-stream').
      rejecting('text/plain', 'text/xml', 'video/mp4', 'image/mkv')}
  
  it "should be able to process file" do
    file = Factory.build :videofile
    file.original.assign File.new(Rails.root.join('spec', 'files', 'test0.avi'))
    file.save!
    file.process_video
        
    # doc - https://github.com/streamio/streamio-ffmpeg
    movie = FFMPEG::Movie.new(file.repacked.path)
    movie.should be_valid
    movie.video_codec.should == 'flv'
  end
  
end
