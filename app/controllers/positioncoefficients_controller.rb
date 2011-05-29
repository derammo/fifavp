class PositioncoefficientsController < ApplicationController
  before_filter :login_required

  # GET /positioncoefficients
  # GET /positioncoefficients.xml
  def index
    @positioncoefficients = Positioncoefficient.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @positioncoefficients }
    end
  end

  # GET /positioncoefficients/1
  # GET /positioncoefficients/1.xml
  def show
    @positioncoefficient = Positioncoefficient.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @positioncoefficient }
    end
  end

  # GET /positioncoefficients/new
  # GET /positioncoefficients/new.xml
  def new
    @positioncoefficient = Positioncoefficient.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @positioncoefficient }
    end
  end

  # GET /positioncoefficients/1/edit
  def edit
    @positioncoefficient = Positioncoefficient.find(params[:id])
  end

  # POST /positioncoefficients
  # POST /positioncoefficients.xml
  def create
    @positioncoefficient = Positioncoefficient.new(params[:positioncoefficient])

    respond_to do |format|
      if @positioncoefficient.save
        format.html { redirect_to(@positioncoefficient, :notice => 'Positioncoefficient was successfully created.') }
        format.xml  { render :xml => @positioncoefficient, :status => :created, :location => @positioncoefficient }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @positioncoefficient.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /positioncoefficients/1
  # PUT /positioncoefficients/1.xml
  def update
    @positioncoefficient = Positioncoefficient.find(params[:id])

    respond_to do |format|
      if @positioncoefficient.update_attributes(params[:positioncoefficient])
        format.html { redirect_to(@positioncoefficient, :notice => 'Positioncoefficient was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @positioncoefficient.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /positioncoefficients/1
  # DELETE /positioncoefficients/1.xml
  def destroy
    @positioncoefficient = Positioncoefficient.find(params[:id])
    @positioncoefficient.destroy

    respond_to do |format|
      format.html { redirect_to(positioncoefficients_url) }
      format.xml  { head :ok }
    end
  end
end
