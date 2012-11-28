require 'srpl/player'

module SRPL

  class Match
    
    attr_accessor :date  # Date : day playing
    attr_reader :player_1, :player_2 # Player : players
    attr_accessor :score_1, :score_2 # Integer : scores
    attr_reader :winner  # Player : winner
    attr_accessor :video # String : url to video
        
    def initialize(player_1, player_2, infos = {})
      @player_1 = player_1
      @player_2 = player_2
      @score_1 = infos[:score_1] ? infos[:score_1].to_i : 0
      @score_2 = infos[:score_2] ? infos[:score_2].to_i : 0
      @date = infos[:date] ? infos[:date] : nil
      @winner = (infos[:winner] && 
                  (infos[:winner] == @player_1 || infos[:winner] == @player_2)) ? infos[:winner] : nil
      @video = infos[:video] ? infos[:video].to_s : nil
    end
    
    def score_1=(score)
      @score_1 = score.to_i
    end
    
    def score_2=(score)
      @score_2 = score.to_i
    end
    
    def player_1_win!
      @winner = @player_1
    end
    
    def player_2_win!
      @winner = @player_2
    end
    
    def finish!(winner, score_w, score_l, video = nil)
      if(winner.to_s == @player_1.to_s || winner == 1)
        @score_1 = score_w.to_i
        @score_2 = score_l.to_i
        player_1_win!
        @video = video
      elsif(winner.to_s == @player_2.to_s || winner == 2)
        @score_1 = score_l.to_i
        @score_2 = score_w.to_i
        player_2_win!
        @video = video
      end
    end
    
    def finished?
      @winner != nil
    end
    
    def player?(player)
      @player_1.to_s == player.to_s || @player_2.to_s == player.to_s
    end
    
    def ==(another_match)
      if another_match.is_a? Match
        (@player_1 == another_match.player_1 && 
          @player_2 == another_match.player_2) ||
        (@player_1 == another_match.player_2 && 
          @player_2 == another_match.player_1)
      else
        false
      end
    end
    
  end

end
