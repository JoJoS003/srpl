require 'srpl/player'
require 'srpl/match'
require 'srpl/matchs_container'

module SRPL

  class League

    include MatchsContainer

    attr_accessor :title, :game
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
      @players
    end

    def find_player(name)
      @players.select do |player|
        player.name == name.to_s
      end
    end

    # Return randomly unplayed matchs for each players
    def round(matches = [])
      round = matches.to_a
      players = []
      round.each { |m| players << m.player_1 << m.player_2 }

      @matchs.shuffle.each do |m|
        unless match_in_rounds?(m) || players.include?(m.player_1) || players.include?(m.player_2) #|| m.finished?
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

    # Refresh players score
    def refresh
      @players.each do |player|
        wins = 0
        defeats = 0
        desertions = 0
        towards = 0
        againsts = 0

        matchs = find_match_by_player(player)
        matchs.each do |match|
          next unless match.finished? # skip unfinished matchs

          if match.winner == player
            wins += 1
          else
            if match.desertion?
              desertions += 1
            else
              defeats += 1
            end
          end

          towards += match.player_1 == player ? match.score_1 : match.score_2
          againsts += match.player_1 == player ? match.score_2 : match.score_1
        end

        player.instance_exec(wins, defeats, desertions, towards, againsts) do |w, d, de, t, a|
          @wins = w
          @defeats = d
          @desertions = de
          @towards = t
          @againsts = a
        end
      end
      self
    end

    def method_missing(method, *args, &block)
      if /^round_(?<index>\w+)$/ =~ method
        @rounds[index.to_i-1]
      else
        super
      end
    end

    def players_in_round(round)
      players = []
      round.matchs.each do |m|
        players << m.player_1 << m.player_2
      end
      players
    end
    
    def stand_off(round)
      @players - players_in_round(round)
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
