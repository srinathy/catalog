require 'spec_helper'

describe Videofile do
  pending "add some examples to (or delete) #{__FILE__}"
  
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
  
  #freezes on test
  #it { should validate_attachment_size(:poster).less_than(500.kilobyte) }
  
  # it { should validate_attachment_content_type(:poster).
  #    allowing('image/png', 'image/gif', 'image/jpeg').
  #    rejecting('text/plain', 'text/xml') 
  # }
  
  it { should have_attached_file(:original) }
  it { should validate_attachment_presence(:original) }
  
  # it { should validate_attachment_content_type(:original).
  #     allowing('video/avi', 'video/mp4', 'image/mkv').
  #     rejecting('text/plain', 'text/xml')}
  
  it { should have_attached_file(:repacked) }
  # it { should validate_attachment_content_type(:original).
  #     allowing('video/flv').
  #     rejecting('text/plain', 'text/xml', 'video/mp4', 'image/mkv')}
  
end
