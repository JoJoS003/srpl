require 'srpl/player'
require 'srpl/match'

module SRPL

  class League
    
    attr_reader :players, :matchs
    
    def initialize(*players)
      @players = players
      @matchs = []
      generate_matchs
    end
    
    def add_player(player)
      @players << player
      generate_matchs
    end

    # Search and return a match contains the two players
    def find_match(p1, p2)
      @matchs.select do |match|
        (match.player_1.to_s == p1.to_s && match.player_2.to_s == p2.to_s) || (match.player_1.to_s == p2.to_s && match.player_2.to_s == p1.to_s)
      end
    end
    
    def find_match_by_player(player)
      @matchs.select do |match|
        match.player_1.to_s == player.to_s || match.player_2.to_s == player.to_s
      end
    end
    
    private
    
    # Génère autant de matchs qu'il y a de possibilités de rencontres entre chaque joueurs
    def generate_matchs
      @players.each do |p1|
        @players.each do |p2|
          next if p1 == p2
          @matchs << Match.new(p1, p2) if find_match(p1, p2).empty?
        end
      end
    end
    
  end
  
end
