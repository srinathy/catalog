require 'spec_helper'

describe Videofile do
  pending "add some examples to (or delete) #{__FILE__}"
  
  #we don't test sanitize, but do test if it is present
  it "should be xss-proof" do
    vf = Factory.stub :videofile
    test = '<SCRIPT SRC=http://ha.ckers.org/xss.js></SCRIPT>'
    vf.body = test
    vf.body.should_not == test
  end
end
