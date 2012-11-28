require 'srpl/match'

module SRPL
  
  # This module factories methods to retrives matchs
  # Includers must have a matchs method returning a matchs array.
  module MatchsContainer

    # Search and return a match contains the two players
    def find_match_by_players(p1, p2)
      matchs.select do |match|
        (match.player_1.to_s == p1.to_s && match.player_2.to_s == p2.to_s) || (match.player_1.to_s == p2.to_s && match.player_2.to_s == p1.to_s)
      end
    end
    alias_method :find_match, :find_match_by_players
    
    def find_match_by_player(player)
      matchs.select do |match|
        match.player_1.to_s == player.to_s || match.player_2.to_s == player.to_s
      end
    end

  end

end
