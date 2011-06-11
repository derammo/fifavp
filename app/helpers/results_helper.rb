module ResultsHelper
  
  def ResultsHelper.poll
    activeplayers = Leagueplayer.joins(:league).where(['leagues.enddate > ? and leagues.startdate < ?', Time.now, Time.now]).select('DISTINCT(player_id)')
    for leagueplayer in activeplayers do
      ResultsHelper.poll_player(leagueplayer.player)
      sleep 5
    end
  end
  
  # function to fetch data from EA and import selectively
  def ResultsHelper.poll_player(player)
    if (player.gamertag && (player.gamertag.length > 0))
      downloaded = PlayersHelper::AccomplishmentsDownload.get('/matchResults/getdata', 
          :query=>{'platformTag'=>'soccer-fifa-11-360',
                   'handle'=>player.gamertag,
                   'platform'=>'360'})
      results = downloaded.parsed_response
      
      # by default, we have to try to individually match the entire set, unless we find a hash match
      tomatch = results.size-1
      matchsince = 0 
      
      # store 1 item match text and 5 item hash for later
      matchtext = Array.new(results.size)
      hash = Array.new(results.size)
      
      if results
        for i in 1 .. (results.size-1)
          matchtext[i] = "#{results[i]['opponentTeam']['handle'][0]}:#{results[i]['selfTeam']['teamName']}:#{results[i]['opponentTeam']['teamName']}:#{results[i]['selfTeam']['score']}:#{results[i]['opponentTeam']['score']}"
          
          # we calculate hashes based on the last 5 items, including the current item
          text = ''
          if (i > 4)
            for j in [i-4, 1].max .. i
              # build the entire 5 item match text
              text << matchtext[j]
              text << "|"
            end
            hash[i] = Digest::SHA1.hexdigest(text)

            # this loop is going from most recent match to oldest, so as soon as we find a match on the hash, we are
            # synchronized
            # check for hash
            matched = Result.first(:conditions => ['hashfive = ? and player1 = ?', hash[i], player.name])
            if matched
              # match one-by-one up to here, which might be zero
              tomatch = i - 1
              
              # limit database to records created after the hash match 
              matchsince = matched.id
              break
            end
          else
            hash[i] = ''
          end
        end
        
        # fetch relevant database records
        #
        # cannot include leagueplayer_id here because the same player can be in multiple leagues
        # and that would result in storing the results several times, so we use 'player1' instead
        imported = Result.all(:conditions => ['player1 = ? and id > ?', player.name, matchsince],
                              :order => 'id DESC')
        importscan = 0
        toadd = tomatch
        
        # check which items we need to add
        for i in 1 .. tomatch do
          # do a trivial match for now (opponent:myteam:theirteam:mygoals:theirgoals)
          importtext = ''
          if imported && imported[importscan] then
            importtext = "#{imported[importscan].player2}:#{imported[importscan].team1}:#{imported[importscan].team2}:#{imported[importscan].goals1.to_s}:#{imported[importscan].goals2.to_s}"
          end
          
          if (importtext == matchtext[i]) then
            # the newest item is already in the database, we are done
            # TODO note this should check context with the rest of the items in the 'imported' set
            toadd = i-1
            break;
          end
        end
        
        # now add new records, in the correct order so that the newest result is newest in the DB as well
        while toadd > 0 do
            # create new records
            Result.create({:player1 => results[toadd]['selfTeam']['handle'],
                           :team1 => results[toadd]['selfTeam']['teamName'],
                           :goals1 => results[toadd]['selfTeam']['score'],
                           :player2 => results[toadd]['opponentTeam']['handle'][0],
                           :team2 => results[toadd]['opponentTeam']['teamName'],
                           :goals2 => results[toadd]['opponentTeam']['score'],
                           :hashfive => hash[toadd]})
            toadd = toadd - 1
        end
      end
    end
  end
end
