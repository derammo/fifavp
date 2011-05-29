class RolevaluesController < ApplicationController
  before_filter :login_required

  # GET /rolevalues
  # GET /rolevalues.xml
  def index
    @rolevalues = Rolevalue.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @rolevalues }
    end
  end

  # GET /rolevalues/1
  # GET /rolevalues/1.xml
  def show
    @rolevalue = Rolevalue.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @rolevalue }
    end
  end

  # GET /rolevalues/new
  # GET /rolevalues/new.xml
  def new
    @rolevalue = Rolevalue.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @rolevalue }
    end
  end

  # GET /rolevalues/1/edit
  def edit
    @rolevalue = Rolevalue.find(params[:id])
  end

  # POST /rolevalues
  # POST /rolevalues.xml
  def create
    @rolevalue = Rolevalue.new(params[:rolevalue])

    respond_to do |format|
      if @rolevalue.save
        format.html { redirect_to(@rolevalue, :notice => 'Rolevalue was successfully created.') }
        format.xml  { render :xml => @rolevalue, :status => :created, :location => @rolevalue }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @rolevalue.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /rolevalues/1
  # PUT /rolevalues/1.xml
  def update
    @rolevalue = Rolevalue.find(params[:id])

    respond_to do |format|
      if @rolevalue.update_attributes(params[:rolevalue])
        format.html { redirect_to(@rolevalue, :notice => 'Rolevalue was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @rolevalue.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /rolevalues/1
  # DELETE /rolevalues/1.xml
  def destroy
    @rolevalue = Rolevalue.find(params[:id])
    @rolevalue.destroy

    respond_to do |format|
      format.html { redirect_to(rolevalues_url) }
      format.xml  { head :ok }
    end
  end
end
