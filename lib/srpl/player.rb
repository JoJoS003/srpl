require 'srpl/rules'

module SRPL

  class Player
  
    include Comparable
    
    attr_reader :name # String : name of player
    attr_reader :email # String : email of player
    attr_accessor :character # String : character playing
    attr_reader :wins, :defeats, :desertions, :opponent_desertions # Integer : scores
    attr_accessor :towards, :againsts

    def initialize(name, character = '', email = '', infos = {})
      @name = name.to_s
      @character = character.to_s
      @email = email.to_s
      @wins = infos[:wins] ? infos[:wins].to_i : 0
      @defeats = infos[:defeats] ? infos[:defeats].to_i : 0
      @desertions = infos[:desertions] ? infos[:desertions].to_i : 0
      @opponent_desertions = infos[:opponent_desertions] ? infos[:opponent_desertions].to_i : 0
      @towards = infos[:towards] ? infos[:towards].to_i : 0
      @againsts = infos[:againsts] ? infos[:againsts].to_i : 0
    end
    
    def plays
      @wins + @defeats
    end
    
    def score
      @wins * WIN_POINTS + @defeats * DEFEAT_POINTS + @desertions * DESERTION_POINTS + @opponent_desertions * OPPONENT_DESERTION_POINTS
    end
    
    def goal_average
      @towards - @againsts
    end
    
    # Type can be win, defeat, desertion, opponent_desertion
    def add(type = 'win')
      instance_variable_set("@#{type}s", instance_variable_get("@#{type}s") + 1)
    end
    
    def method_missing(method_name, *args, &block)
      if(/^add_(?<type>\w+)$/ =~ method_name)
        send("add", type)
      else
        super
      end
    end
    
    def ==(another_player)
      if another_player.is_a? Player
        @name == another_player.name
      else
        false
      end
    end
    
    def <=>(another_player)
      score_ordering = another_player.score <=> score
      if score_ordering == 0
        score_ordering = another_player.goal_average <=> goal_average
      end
      if score_ordering == 0
        score_ordering = @name <=> another_player.name
      end
      score_ordering
    end
    
    def to_s
      @name.to_s
    end
    
  end

end
