class PlayeraccomplishmentsController < ApplicationController
  before_filter :login_required

  # GET /playeraccomplishments
  # GET /playeraccomplishments.xml
  def index
    @playeraccomplishments = Playeraccomplishment.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @playeraccomplishments }
    end
  end

  # GET /playeraccomplishments/1
  # GET /playeraccomplishments/1.xml
  def show
    @playeraccomplishment = Playeraccomplishment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @playeraccomplishment }
    end
  end

  # GET /playeraccomplishments/new
  # GET /playeraccomplishments/new.xml
  def new
    @playeraccomplishment = Playeraccomplishment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @playeraccomplishment }
    end
  end

  # GET /playeraccomplishments/1/edit
  def edit
    @playeraccomplishment = Playeraccomplishment.find(params[:id])
  end

  # POST /playeraccomplishments
  # POST /playeraccomplishments.xml
  def create
    @playeraccomplishment = Playeraccomplishment.new(params[:playeraccomplishment])

    respond_to do |format|
      if @playeraccomplishment.save
        format.html { redirect_to(@playeraccomplishment, :notice => 'Playeraccomplishment was successfully created.') }
        format.xml  { render :xml => @playeraccomplishment, :status => :created, :location => @playeraccomplishment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @playeraccomplishment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /playeraccomplishments/1
  # PUT /playeraccomplishments/1.xml
  def update
    @playeraccomplishment = Playeraccomplishment.find(params[:id])

    respond_to do |format|
      if @playeraccomplishment.update_attributes(params[:playeraccomplishment])
        format.html { redirect_to(@playeraccomplishment, :notice => 'Playeraccomplishment was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @playeraccomplishment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /playeraccomplishments/1
  # DELETE /playeraccomplishments/1.xml
  def destroy
    @playeraccomplishment = Playeraccomplishment.find(params[:id])
    @playeraccomplishment.destroy

    respond_to do |format|
      format.html { redirect_to(playeraccomplishments_url) }
      format.xml  { head :ok }
    end
  end
end
