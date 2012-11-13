require 'srpl/player'
require 'srpl/match'

module SRPL

  class League
    
    attr_reader :players, :matchs
    
    def initialize(*players)
      @players = players
      @matchs = []
    end
    
    def add_player(player)
      @players << player
    end

    # Search and return a match contains the two players
    def match(p1, p2)
      match = @matchs.each do |match|
        return match if match.player_1 == p1 && match.player_2 == p2
      end
    end
    
    private
    
    # Génère autant de matchs qu'il y a de possibilités de rencontres entre chaque joueurs
    def generate_matches
    end
    
  end
  
end
