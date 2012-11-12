require 'league/player'
require 'league/match'

module League

  class League
    
    attr_reader :players, :matchs
    
    def initialize(players = [])
      @players = players
      @matchs = []
    end
    
    def add_player(player)
      @players << player
    end
    
    private
    
    # Génère autant de matchs qu'il y a de possibilités de rencontres entre chaque joueurs
    def generate_matches
      
    end
    
  end
  
end
