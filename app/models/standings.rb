class Standings < Array
  class Record
    attr_accessor :player, :games, :played, :won, :lost, :drawn, :goals_for, :goals_against
    
    def initialize
      @player = nil
      @games = 0
      @played = 0
      @won = 0
      @lost = 0
      @drawn = 0
      @goals_for = 0
      @goals_against = 0
    end
    
    def points
      return (@won * 3) + @drawn
    end
    
    def goal_differential
      return @goals_for - @goals_against
    end
  end
  
  def readGames(league)
    @player_records = Hash.new
    
    # now read the games
    league.games.each do |game|
      if ((!game.player1) || (!game.player1.active) || (!game.player2) || (!game.player2.active)) then
        # this game does not matter any more
        next
      end
      player1 = fetchOrCreate(game.player1.player)
      player2 = fetchOrCreate(game.player2.player)
      
      player1.games += 1
      player2.games += 1
      
      result = game.result
      if result then
        # figure out whether the result is recorded backwards
        if player1.player.gamertag == result.player1 then
          score1 = result.goals1
          score2 = result.goals2
        else
          score1 = result.goals2
          score2 = result.goals1
        end
        player1.played += 1
        player2.played += 1
        player1.goals_for += score1
        player1.goals_against += score2
        player2.goals_for += score2
        player2.goals_against += score1
        if score1 > score2 then
          player1.won += 1
          player2.lost += 1
        elsif score1 < score2 then
          player1.lost += 1
          player2.won += 1
        else
          player1.drawn += 1
          player2.drawn += 1
        end
      end
    end
    
    # finally, sort the results
    self.replace(@player_records.to_a.sort_by {|k,v| [-v.points, -v.goal_differential]}) 
  end

  private 
  def fetchOrCreate(player)
    key = player.gamertag
    item = @player_records[key]
    if !item then
      item = Standings::Record.new
      item.player = player
      @player_records[key] = item
    end
    return item
  end
end
