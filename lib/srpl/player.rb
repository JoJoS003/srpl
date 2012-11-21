require 'srpl/rules'

module SRPL

  class Player
    
    attr_reader :name # String : name of player
    attr_reader :email # String : email of player
    attr_accessor :character # String : character playing
    attr_reader :wins, :defeats, :desertions, :opponent_desertions # Integer : scores

    def initialize(name, character, email, infos = {})
      @name = name.to_s
      @character = character.to_s
      @email = email.to_s
      @wins = infos[:wins] ? infos[:wins].to_i : 0
      @defeats = infos[:defeats] ? infos[:defeats].to_i : 0
      @desertions = infos[:desertions] ? infos[:desertions].to_i : 0
      @opponent_desertions = infos[:opponent_desertions] ? infos[:opponent_desertions].to_i : 0
    end

    def score
      @wins * WIN_POINTS + @defeats * DEFEAT_POINTS + @desertions * DESERTION_POINTS + @opponent_desertions * OPPONENT_DESERTION_POINTS
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
    
  end

end
