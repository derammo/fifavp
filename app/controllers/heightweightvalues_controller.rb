class HeightweightvaluesController < ApplicationController
  before_filter :login_required

  # GET /heightweightvalues
  # GET /heightweightvalues.xml
  def index
    @heightweightvalues = Heightweightvalue.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @heightweightvalues }
    end
  end

  # GET /heightweightvalues/1
  # GET /heightweightvalues/1.xml
  def show
    @heightweightvalue = Heightweightvalue.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @heightweightvalue }
    end
  end

  # GET /heightweightvalues/new
  # GET /heightweightvalues/new.xml
  def new
    @heightweightvalue = Heightweightvalue.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @heightweightvalue }
    end
  end

  # GET /heightweightvalues/1/edit
  def edit
    @heightweightvalue = Heightweightvalue.find(params[:id])
  end

  # POST /heightweightvalues
  # POST /heightweightvalues.xml
  def create
    @heightweightvalue = Heightweightvalue.new(params[:heightweightvalue])

    respond_to do |format|
      if @heightweightvalue.save
        format.html { redirect_to(@heightweightvalue, :notice => 'Heightweightvalue was successfully created.') }
        format.xml  { render :xml => @heightweightvalue, :status => :created, :location => @heightweightvalue }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @heightweightvalue.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /heightweightvalues/1
  # PUT /heightweightvalues/1.xml
  def update
    @heightweightvalue = Heightweightvalue.find(params[:id])

    respond_to do |format|
      if @heightweightvalue.update_attributes(params[:heightweightvalue])
        format.html { redirect_to(@heightweightvalue, :notice => 'Heightweightvalue was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @heightweightvalue.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /heightweightvalues/1
  # DELETE /heightweightvalues/1.xml
  def destroy
    @heightweightvalue = Heightweightvalue.find(params[:id])
    @heightweightvalue.destroy

    respond_to do |format|
      format.html { redirect_to(heightweightvalues_url) }
      format.xml  { head :ok }
    end
  end
end
