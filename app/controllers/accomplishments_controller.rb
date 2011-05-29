class AccomplishmentsController < ApplicationController
  before_filter :login_required

  # GET /accomplishments
  # GET /accomplishments.xml
  def index
    @accomplishments = Accomplishment.all(:order=>'section,linenumber')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @accomplishments }
    end
  end

  # GET /accomplishments/1
  # GET /accomplishments/1.xml
  def show
    @accomplishment = Accomplishment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @accomplishment }
    end
  end

  # GET /accomplishments/new
  # GET /accomplishments/new.xml
  def new
    @accomplishment = Accomplishment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @accomplishment }
    end
  end

  # GET /accomplishments/1/edit
  def edit
    @accomplishment = Accomplishment.find(params[:id])
  end

  # POST /accomplishments
  # POST /accomplishments.xml
  def create
    @accomplishment = Accomplishment.new(params[:accomplishment])

    respond_to do |format|
      if @accomplishment.save
        format.html { redirect_to(@accomplishment, :notice => 'Accomplishment was successfully created.') }
        format.xml  { render :xml => @accomplishment, :status => :created, :location => @accomplishment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @accomplishment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /accomplishments/1
  # PUT /accomplishments/1.xml
  def update
    @accomplishment = Accomplishment.find(params[:id])

    respond_to do |format|
      if @accomplishment.update_attributes(params[:accomplishment])
        format.html { redirect_to(@accomplishment, :notice => 'Accomplishment was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @accomplishment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /accomplishments/1
  # DELETE /accomplishments/1.xml
  def destroy
    @accomplishment = Accomplishment.find(params[:id])
    @accomplishment.destroy

    respond_to do |format|
      format.html { redirect_to(accomplishments_url) }
      format.xml  { head :ok }
    end
  end
end
