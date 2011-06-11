class LeagueplayersController < ApplicationController
  before_filter :login_required

  # GET /leagueplayers
  # GET /leagueplayers.xml
  def index
    @leagueplayers = Leagueplayer.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @leagueplayers }
    end
  end
  
  # GET /leagueplayers/1
  # GET /leagueplayers/1.xml
  def show
    @leagueplayer = Leagueplayer.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @leagueplayer }
    end
  end
  
  # GET /leagueplayers/new
  # GET /leagueplayers/new.xml
  def new
    @leagueplayer = Leagueplayer.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @leagueplayer }
    end
  end
  
  # GET /leagueplayers/1/edit
  def edit
    @leagueplayer = Leagueplayer.find(params[:id])
  end
  
  # POST /leagueplayers
  # POST /leagueplayers.xml
  def create
    @leagueplayer = Leagueplayer.new(params[:leagueplayer])
    
    respond_to do |format|
      if @leagueplayer.save
        format.html { redirect_to(@leagueplayer, :notice => 'Leagueplayer was successfully created.') }
        format.xml  { render :xml => @leagueplayer, :status => :created, :location => @leagueplayer }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @leagueplayer.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /leagueplayers/1
  # PUT /leagueplayers/1.xml
  def update
    @leagueplayer = Leagueplayer.find(params[:id])
    
    respond_to do |format|
      if @leagueplayer.update_attributes(params[:leagueplayer])
        format.html { redirect_to(@leagueplayer, :notice => 'Leagueplayer was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @leagueplayer.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # DELETE /leagueplayers/1
  # DELETE /leagueplayers/1.xml
  def destroy
    @leagueplayer = Leagueplayer.find(params[:id])
    @leagueplayer.destroy
    
    respond_to do |format|
      format.html { redirect_to(leagueplayers_url) }
      format.xml  { head :ok }
    end
  end
 
end
