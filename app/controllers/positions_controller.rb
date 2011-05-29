class PositionsController < ApplicationController
  # login is NOT required for GET
  before_filter :login_required, :except => :show

  # GET /positions
  # GET /positions.xml
  def index
    @positions = Position.all(:order=>'name')
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @positions }
    end
  end
  
  # GET /positions/1
  # GET /positions/1.xml
  def show
    @position = Position.find(params[:id])
    @sortedvalues = @position.positioncoefficients.sort_by { 
      |relevant| -(relevant.coefficient) }
    
    # TODO only do this when there is a query string
    @skillpoints = Hash.new
    skillcoefficients = Hash.new
    @possiblepoints = Hash.new
    
    # initialize skill hashes 
    for relevant in @sortedvalues do
      skillcoefficients.store(relevant.skill_id, relevant.coefficient)
      @possiblepoints.store(relevant.skill_id, 99 * relevant.coefficient)
      @skillpoints.store(relevant.skill_id, 0)
    end
    
    # preload with constants
    @skillpoints[Skill.first(:conditions=>{:name=>'Reactions'}).id] = 70
    @skillpoints[Skill.first(:conditions=>{:name=>'Weak Foot Ability'}).id] = 0
    
    # optional query string 'role' to calculate suitability
    if params[:role] 
      @role = Role.find(params[:role])
    end
    if @role 
      @rolevalues = Hash.new 
      for relevant in @sortedvalues do
        # this better have zero or one match
        rolevalue = Rolevalue.first(:conditions=>{
			:role_id=>@role.id,
			:skill_id=>relevant.skill_id})
        
        if rolevalue 
          @rolevalues.store(relevant.skill_id, rolevalue)
          @skillpoints[relevant.skill_id] += rolevalue.value
        end
      end
    end
    
    # optional query string 'heightweight' to calculate suitability
    if params[:heightweight] 
      # height and weight are specified, selection set is empty
      @heightweight = Heightweight.find(params[:heightweight])
      @heightweights = Array.new
    else
      # allow caller to choose one
      @heightweights = Heightweight.all
    end
    if @heightweight 
      @heightweightvalues = Hash.new 
      for relevant in @sortedvalues do
        # this better have zero or one match
        heightweightvalue = Heightweightvalue.first(:conditions=>{
			:heightweight_id=>@heightweight.id,
			:skill_id=>relevant.skill_id})
        
        if heightweightvalue 
          @heightweightvalues.store(relevant.skill_id, heightweightvalue)
          @skillpoints[relevant.skill_id] += heightweightvalue.value
        end
      end
    end
    
    # always present, but frequently empty 
    @improvements = Hash.new
    recommended = Hash.new
    
    # optional query string 'player' to calculate accomplishments
    if params[:player] then 
      @player = Player.find(params[:player])
    else
      if logged_in? then
        @players = Player.all(:conditions => {:owner=>current_user.login})
        if @players.count > 0 then
          @player = @players[0]
        end
      end
    end
    if @player
      @possibleboosts = Hash.new 
      @playerboosts = Hash.new 
      for relevant in @sortedvalues do
        @playerboosts[relevant.skill_id] = 0 
        @possibleboosts[relevant.skill_id] = 0 
        accomplishments = Accomplishment.all(:conditions=>{
			:skill_id=>relevant.skill_id})
        
        for accomplishment in accomplishments
          if @player then
            status = @player.playeraccomplishments.find_by_accomplishment_id(accomplishment.id)
            if status && status.achieved then
              # player has this accomplishment, sum it up
              @playerboosts[relevant.skill_id] += accomplishment.skillamount 
            else
              # note any accomplishments that would help
              if !recommended.has_key?(relevant.skill_id) then
                recommended[relevant.skill_id] = Array.new
              end
              recommended[relevant.skill_id] << accomplishment
            end
          end
          @possibleboosts[relevant.skill_id] += accomplishment.skillamount 
        end
        
        # sort recommendation descending by value, within one skill 
        if recommended[relevant.skill_id] then
          @improvements[relevant.skill_id] = recommended[relevant.skill_id].sort_by {|acc| -(acc.skillamount)}
        end
        
        # sum up skill points
        if @skillpoints.has_key?(relevant.skill_id) then
          @skillpoints[relevant.skill_id] += @playerboosts[relevant.skill_id]
        else
          @skillpoints[relevant.skill_id] = @playerboosts[relevant.skill_id]
        end
      end
    end
    
    # multiply totals by coefficients
    @rating = 0
    @skillpoints.each do |k,v|
      if @skillpoints[k] and skillcoefficients[k]
        @skillpoints[k] = v * skillcoefficients[k]
        @rating += @skillpoints[k]
      end
    end
    @rating = @rating / 99
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @position }
    end
  end
  
  # GET /positions/new
  # GET /positions/new.xml
  def new
    @position = Position.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @position }
    end
  end
  
  # GET /positions/1/edit
  def edit
    @position = Position.find(params[:id])
  end
  
  # POST /positions
  # POST /positions.xml
  def create
    @position = Position.new(params[:position])
    
    respond_to do |format|
      if @position.save
        format.html { redirect_to(@position, :notice => 'Position was successfully created.') }
        format.xml  { render :xml => @position, :status => :created, :location => @position }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @position.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /positions/1
  # PUT /positions/1.xml
  def update
    @position = Position.find(params[:id])
    
    respond_to do |format|
      if @position.update_attributes(params[:position])
        format.html { redirect_to(@position, :notice => 'Position was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @position.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # DELETE /positions/1
  # DELETE /positions/1.xml
  def destroy
    @position = Position.find(params[:id])
    @position.destroy
    
    respond_to do |format|
      format.html { redirect_to(positions_url) }
      format.xml  { head :ok }
    end
  end
end
