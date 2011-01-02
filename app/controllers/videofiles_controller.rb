class VideofilesController < ApplicationController
  uses_tiny_mce
  before_filter :authenticate_admin!, :except => [:index, :show]
    
  # GET /videofiles
  # GET /videofiles.xml
  def index
    @videofiles = Videofile.search params[:page], params[:category]
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @videofiles }
    end
  end

  # GET /videofiles/1
  # GET /videofiles/1.xml
  def show
    @videofile = Videofile.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @videofile }
    end
  end

  # GET /videofiles/new
  # GET /videofiles/new.xml
  def new
    @videofile = Videofile.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @videofile }
    end
  end

  # GET /videofiles/1/edit
  def edit
    @videofile = Videofile.find(params[:id])
  end

  # POST /videofiles
  # POST /videofiles.xml
  def create
    @videofile = Videofile.new(params[:videofile])
    
    respond_to do |format|
      if @videofile.save
        format.html { redirect_to(@videofile, :notice => 'Videofile was successfully created.') }
        format.xml  { render :xml => @videofile, :status => :created, :location => @videofile }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @videofile.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /videofiles/1
  # PUT /videofiles/1.xml
  def update
    @videofile = Videofile.find(params[:id])

    respond_to do |format|
      if @videofile.update_attributes(params[:videofile])
        format.html { redirect_to(@videofile, :notice => 'Videofile was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @videofile.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /videofiles/1
  # DELETE /videofiles/1.xml
  def destroy
    @videofile = Videofile.find(params[:id])
    @videofile.destroy

    respond_to do |format|
      format.html { redirect_to(videofiles_url) }
      format.xml  { head :ok }
    end
  end
end
