require "spec_helper"

describe VideofilesController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/videofiles" }.should route_to(:controller => "videofiles", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/videofiles/new" }.should route_to(:controller => "videofiles", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/videofiles/1" }.should route_to(:controller => "videofiles", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/videofiles/1/edit" }.should route_to(:controller => "videofiles", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/videofiles" }.should route_to(:controller => "videofiles", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/videofiles/1" }.should route_to(:controller => "videofiles", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/videofiles/1" }.should route_to(:controller => "videofiles", :action => "destroy", :id => "1")
    end
    
    it "routes main page to #index" do
      { :get => ""}.should route_to(:controller => "videofiles", :action => "index")
    end
  end
end
