class PlayersController < ApplicationController
  before_filter :login_required
  
  # GET /players
  # GET /players.xml
  def index
    if current_user.admin? then
      # admin can edit any player
      @players = Player.all
    else
      # regular user can only edit own players
      @players = Player.all(:conditions=> ['LOWER(owner) = ?', current_user.login])
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @players }
    end
  end
  
  # GET /players/1
  # GET /players/1.xml
  def show  
    @player = Player.find(params[:id])
    
    # load accomplishments that are done
    @accomplishmentsdone = Playeraccomplishment.all(
      :conditions=>{:achieved=>true, :player_id=> @player.id}, 
      :include=>:accomplishment).sort_by {
        |status| [status.accomplishment.section, 
        status.accomplishment.linenumber]}
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @player }
    end
  end
  
  # GET /players/new
  # GET /players/new.xml
  def new
    @player = Player.new
    @player.owner = current_user.login
    existingrecords = Hash.new
    accomplishmentstates = Array.new
    
    # cannot load existing accomplishments since new id is not known

    # create missing (new) records
    missing = Accomplishment.all
    for accomplishment in missing do
      if !(existingrecords.has_key?(accomplishment.id)) then
        accomplishmentstate = Playeraccomplishment.new
        accomplishmentstate.achieved = false
        accomplishmentstate.player = @player
        accomplishmentstate.accomplishment = accomplishment
        accomplishmentstates << accomplishmentstate 
      end
    end
    
    @accomplishmentsedit = accomplishmentstates.sort_by {
      |status| [status.accomplishment.section, 
      status.accomplishment.linenumber]}
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @player }
    end
  end
  
  # GET /players/1/edit
  def edit
    @player = Player.find(params[:id])
    existingrecords = Hash.new
    
    # load accomplishments 
    accomplishmentstates = Playeraccomplishment.all(:conditions=>['player_id = ?', @player.id.to_s]);
    for status in accomplishmentstates do
      # remember for later
      existingrecords[status.accomplishment_id] = true
    end
    
    # look for any missing ones (i.e. accomplishment exists but no rel record)
    missing = Accomplishment.all
    for accomplishment in missing do
      if !(existingrecords.has_key?(accomplishment.id)) then
        accomplishmentstate = Playeraccomplishment.new
        accomplishmentstate.achieved = false
        accomplishmentstate.player = @player
        accomplishmentstate.accomplishment = accomplishment
        accomplishmentstates << accomplishmentstate 
      end
    end
    
    @accomplishmentsedit = accomplishmentstates.sort_by {
      |status| [status.accomplishment.section, 
      status.accomplishment.linenumber]}
  end
  
  # POST /players
  # POST /players.xml
  def create
    @player = Player.new(params[:player])
    
    # can't change/choose this
    @player.owner = current_user.login

    # XXX gruesome hack until I can figure out how to make the import button call a different action
    if (params[:commit] == 'Import')
      return import
    end

    # write accomplishment records for those accomplishments achieved
    missing = Accomplishment.all;
    for accomplishment in missing do
      if params.key?("accomplishment_"+accomplishment.id.to_s) then
        accomplishmentstate = Playeraccomplishment.new
        accomplishmentstate.achieved = true
        accomplishmentstate.player = @player
        accomplishmentstate.accomplishment = accomplishment
          
        # write
        accomplishmentstate.save
      end
    end
    
    respond_to do |format|
      if @player.save
        format.html { redirect_to(@player, :notice => 'Player was successfully created.') }
        format.xml  { render :xml => @player, :status => :created, :location => @player }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @player.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /players/1
  # PUT /players/1.xml
  def update
    @player = Player.find(params[:id])
    
    if !(current_user.admin? || (current_user.login == @player.owner.downcase)) then
      # TODO how to report error?
      respond_to do |format|
        format.html { redirect_to(@player, :notice => 'Player cannot be updated.') }
        format.xml  { head :ok }
      end
      return
    end
    
    # XXX gruesome hack until I can figure out how to make the import button call a different action
    if (params[:commit] == 'Import')
      return import
    end
    
    existingrecords = Hash.new
    
    # load accomplishments 
    accomplishmentstates = Playeraccomplishment.all(:conditions=>['player_id = ?', @player.id.to_s])
    for status in accomplishmentstates do
      # remember for later
      existingrecords[status.accomplishment_id] = true
      
      # check if status changed (careful to force both to boolean)
      if status.achieved && 
        !params.key?("accomplishment_"+status.accomplishment_id.to_s) then
        status.achieved = false 
        status.save
      else 
        if !status.achieved && 
          params.key?("accomplishment_"+status.accomplishment_id.to_s) then
          status.achieved = true
          status.save
        end 
      end  
    end
    
    # look for any missing ones (i.e. accomplishment exists but no rel record)
    missing = Accomplishment.all;
    for accomplishment in missing do
      if params.key?("accomplishment_"+accomplishment.id.to_s) then
        if !existingrecords.key?(accomplishment.id) then
          accomplishmentstate = Playeraccomplishment.new
          accomplishmentstate.achieved = true
          accomplishmentstate.player = @player
          accomplishmentstate.accomplishment = accomplishment
          
          # write
          accomplishmentstate.save
        end
      end
    end
    
    # can't change owner
    params[:player].delete("owner")
    
    respond_to do |format|
      if @player.update_attributes(params[:player])
        format.html { redirect_to(@player, :notice => 'Player was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @player.errors, :status => :unprocessable_entity }
      end
    end
    
  end
  
  # DELETE /players/1
  # DELETE /players/1.xml
  def destroy
    @player = Player.find(params[:id])
    
    if current_user.admin? || (current_user.login == @player.owner.downcase) then
      @player.destroy
    else
      # TODO how to report error?
    end
    
    respond_to do |format|
      format.html { redirect_to(players_url) }
      format.xml  { head :ok }
    end
  end

  # POST /players/1/import
  def import
    # sometimes we are called from 'create' so we don't have an ID, but @player will already be set
    # in those cases
    if params[:id] then
      @player = Player.find(params[:id])
    end
    
    if !(current_user.admin? || (current_user.login == @player.owner.downcase)) then
      # TODO how to report error?
      respond_to do |format|
        format.html { redirect_to(@player, :notice => 'Player cannot be updated.') }
        format.xml  { head :ok }
      end
      return
    end
    
    # do the import
    if (params[:player][:gamertag] && (params[:player][:gamertag].length > 0)) then
      # /getdata?platformTag=soccer-fifa-11-360&handle=GinTonicLime&platform=360
      @downloaded = PlayersHelper::AccomplishmentsDownload.get('/accomplishments/getdata', 
        :query=>{'platformTag'=>'soccer-fifa-11-360',
                 'handle'=>params[:player][:gamertag],
                 'platform'=>'360'})
      if @downloaded.parsed_response['accomplishments'] 
        # only remaining accomplishments will be those downloaded
        @player.playeraccomplishments.destroy_all
      
        for accomplishment in @downloaded.parsed_response['accomplishments'] do
          if accomplishment['status'] == 'true' then
            # has been achieved
            section = accomplishment['category']
            linenumber = accomplishment['label'].split(")")[0]
            found = Accomplishment.first(:conditions=>['section = ? and linenumber = ?', section, linenumber])
            if found then
              @player.playeraccomplishments.build(:accomplishment => found, :achieved => true)
            end
          end
        end
      end
    end

    # can't change owner
    params[:player].delete("owner")
    
    respond_to do |format|
      if @player.update_attributes(params[:player])
        format.html { redirect_to(@player, :notice => 'Player was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @player.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  protected
  def authorized?(action = action_name, resource = nil)
    # read and write permitted
    logged_in?
  end  
end
