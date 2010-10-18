require 'spec_helper'

describe VideofilesController do

  def mock_videofile(stubs={})
    (@mock_videofile ||= mock_model(Videofile).as_null_object).tap do |videofile|
      videofile.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all videofiles as @videofiles" do
      Videofile.stub(:paginate) { [mock_videofile] }
      get :index
      assigns(:videofiles).should eq([mock_videofile])
    end
  end

  describe "GET show" do
    it "assigns the requested videofile as @videofile" do
      Videofile.stub(:find).with("37") { mock_videofile }
      get :show, :id => "37"
      assigns(:videofile).should be(mock_videofile)
    end
  end

  describe "GET new" do
    it "assigns a new videofile as @videofile" do
      Videofile.stub(:new) { mock_videofile }
      get :new
      assigns(:videofile).should be(mock_videofile)
    end
  end

  describe "GET edit" do
    it "assigns the requested videofile as @videofile" do
      Videofile.stub(:find).with("37") { mock_videofile }
      get :edit, :id => "37"
      assigns(:videofile).should be(mock_videofile)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created videofile as @videofile" do
        Videofile.stub(:new).with({'these' => 'params'}) { mock_videofile(:save => true) }
        post :create, :videofile => {'these' => 'params'}
        assigns(:videofile).should be(mock_videofile)
      end

      it "redirects to the created videofile" do
        Videofile.stub(:new) { mock_videofile(:save => true) }
        post :create, :videofile => {}
        response.should redirect_to(videofile_url(mock_videofile))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved videofile as @videofile" do
        Videofile.stub(:new).with({'these' => 'params'}) { mock_videofile(:save => false) }
        post :create, :videofile => {'these' => 'params'}
        assigns(:videofile).should be(mock_videofile)
      end

      it "re-renders the 'new' template" do
        Videofile.stub(:new) { mock_videofile(:save => false) }
        post :create, :videofile => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested videofile" do
        Videofile.should_receive(:find).with("37") { mock_videofile }
        mock_videofile.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :videofile => {'these' => 'params'}
      end

      it "assigns the requested videofile as @videofile" do
        Videofile.stub(:find) { mock_videofile(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:videofile).should be(mock_videofile)
      end

      it "redirects to the videofile" do
        Videofile.stub(:find) { mock_videofile(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(videofile_url(mock_videofile))
      end
    end

    describe "with invalid params" do
      it "assigns the videofile as @videofile" do
        Videofile.stub(:find) { mock_videofile(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:videofile).should be(mock_videofile)
      end

      it "re-renders the 'edit' template" do
        Videofile.stub(:find) { mock_videofile(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested videofile" do
      Videofile.should_receive(:find).with("37") { mock_videofile }
      mock_videofile.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the videofiles list" do
      Videofile.stub(:find) { mock_videofile }
      delete :destroy, :id => "1"
      response.should redirect_to(videofiles_url)
    end
  end

end
