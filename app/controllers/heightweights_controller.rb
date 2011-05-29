class HeightweightsController < ApplicationController
  before_filter :login_required

  # GET /heightweights
  # GET /heightweights.xml
  def index
    @heightweights = Heightweight.all(:order=>'name')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @heightweights }
    end
  end

  # GET /heightweights/1
  # GET /heightweights/1.xml
  def show
    @heightweight = Heightweight.find(params[:id])
    @sortedvalues = @heightweight.heightweightvalues.sort_by { |heightweightvalue| heightweightvalue.skill.name }

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @heightweight }
    end
  end

  # GET /heightweights/new
  # GET /heightweights/new.xml
  def new
    @heightweight = Heightweight.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @heightweight }
    end
  end

  # GET /heightweights/1/edit
  def edit
    @heightweight = Heightweight.find(params[:id])
  end

  # POST /heightweights
  # POST /heightweights.xml
  def create
    @heightweight = Heightweight.new(params[:heightweight])

    respond_to do |format|
      if @heightweight.save
        format.html { redirect_to(@heightweight, :notice => 'Heightweight was successfully created.') }
        format.xml  { render :xml => @heightweight, :status => :created, :location => @heightweight }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @heightweight.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /heightweights/1
  # PUT /heightweights/1.xml
  def update
    @heightweight = Heightweight.find(params[:id])

    respond_to do |format|
      if @heightweight.update_attributes(params[:heightweight])
        format.html { redirect_to(@heightweight, :notice => 'Heightweight was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @heightweight.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /heightweights/1
  # DELETE /heightweights/1.xml
  def destroy
    @heightweight = Heightweight.find(params[:id])
    @heightweight.destroy

    respond_to do |format|
      format.html { redirect_to(heightweights_url) }
      format.xml  { head :ok }
    end
  end
end
