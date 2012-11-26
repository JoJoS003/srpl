require 'srpl/player'
require 'srpl/match'

module SRPL

  class League
    
    attr_reader :players, :matchs, :rounds
    
    def initialize(*players)
      @players = players
      @matchs = []
      @rounds = []
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
    
    # Return randomly unplayed matchs for each players
    def round
      round = []
      players = []
      
      @matchs.shuffle.each do |m|
        unless match_in_rounds?(m) || m.finished? || players.include?(m.player_1) || players.include?(m.player_2)
          round << m
          players << m.player_1
          players << m.player_2
        end
      end
      
      round
    end
    
    # Return copy of players sorted by score
    def rank
#      rank = @players.sort
#      rank.each { |player| yield player } if block_given?
      @players.sort
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
    
    def match_in_rounds?(match)
      @rounds.each do |round|
        return true if round.include? match
      end
      false
    end
    
  end
  
end
