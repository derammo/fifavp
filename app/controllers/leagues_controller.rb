class LeaguesController < ApplicationController
  before_filter :login_required, :except => :show

  # GET /leagues
  # GET /leagues.xml
  def index
    @leagues = League.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @leagues }
    end
  end

  # GET /leagues/1
  # GET /leagues/1.xml
  def show
    @league = League.find(params[:id])

    # first, claim any results for games that need one
    for game in @league.games do
      if !game.result then
        if game.player1 && game.player1.active && game.player2 && game.player2.active then
          # HACK we are always using the result imported for the ASCII-first player so that we don't
          # claim the same result for the home and away game (note that each result appears in both players' imports)
          results = Result.all(:order => 'id', 
            :conditions => ['game_id is null and player1 = ? and player2 = ? and created_at > ? and created_at < ?',
            [game.player1.player.name, game.player2.player.name].min,
            [game.player1.player.name, game.player2.player.name].max,
            game.league.startdate,
            game.league.enddate.to_date + 1])
            
          if results && (results.size > 0) then
            # use as our result 
            game.result = results[0]
            
            # claim it
            game.result.game_id = game.id
            game.result.save
            
            # XXX make this one transaction
            game.save
          end
        else
          # game does not matter any more and it has no result
          game.destroy
        end
      end
    end

    # calculate league table
    @standings = Standings.new
    @standings.readGames(@league)
    
    # sort the games to make the list more interesting
    @sortedgames = @league.games.sort {|l,r|
      if l.result then
        if r.result then
          # descending by date, newest first
          r.result.created_at <=> l.result.created_at
        else
          # result wins
          -1
        end          
      else
        # no result on left side
        if r.result then
          # result wins
          1
        else
          # sort names
          (l.player1 ? l.player1.player.name : '') <=> (r.player1 ? r.player1.player.name : '') 
        end
      end
    }
    
    # collect inactive players for second table
    @inactive = Leagueplayer.all(:conditions => ['league_id = ? and active = ?', @league.id, false])
    if ! @inactive then
      @inactive = []
    end
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @league }
    end
  end

  # GET /leagues/new
  # GET /leagues/new.xml
  def new
    @league = League.new

    # load up all possible league players for editing
    # (we will remove them before persisting if they are not selected)
    for player in Player.all do
      @league.leagueplayers.build(:player=>player, :active=>false)
    end
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @league }
    end
  end

  # GET /leagues/1/edit
  def edit
    @league = League.find(params[:id])
  end

  # POST /leagues
  # POST /leagues.xml
  def create
    @league = League.new(params[:league])
    
    # remove those elements that are not selected, so they don't get written
    @league.leagueplayers.delete_if {|p| p.active == false} 
    
    # create games for all those players that made it
    for player1 in @league.leagueplayers do
      for player2 in @league.leagueplayers do
        if player1 != player2 then
          @league.games.build(:player1 => player1, :player2 => player2)
        end
      end
    end
    
    respond_to do |format|
      if @league.save
        format.html { redirect_to(@league, :notice => 'League was successfully created.') }
        format.xml  { render :xml => @league, :status => :created, :location => @league }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @league.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /leagues/1
  # PUT /leagues/1.xml
  def update
    @league = League.find(params[:id])

    respond_to do |format|
      if @league.update_attributes(params[:league])
        format.html { redirect_to(@league, :notice => 'League was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @league.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /leagues/1
  # DELETE /leagues/1.xml
  def destroy
    @league = League.find(params[:id])
    @league.destroy

    respond_to do |format|
      format.html { redirect_to(leagues_url) }
      format.xml  { head :ok }
    end
  end
end
