require 'srpl/rules'

module SRPL

  class Player

    include Comparable

    attr_reader :name # String : name of player
    attr_reader :infos # Hash : informations of player
    attr_accessor :character # String : character playing
    attr_reader :wins, :defeats, :desertions, :opponent_desertions # Integer : scores
    attr_accessor :towards, :againsts

    def initialize(name, character = '', points = {}, infos = {})
      @name = name.to_s
      @character = character.to_s
      @wins = points[:wins] ? points[:wins].to_i : 0
      @defeats = points[:defeats] ? points[:defeats].to_i : 0
      @desertions = points[:desertions] ? points[:desertions].to_i : 0
      @opponent_desertions = points[:opponent_desertions] ? points[:opponent_desertions].to_i : 0
      @towards = points[:towards] ? points[:towards].to_i : 0
      @againsts = points[:againsts] ? points[:againsts].to_i : 0
      @infos = infos
    end

    def plays
      @wins + @defeats + @desertions
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
      # add the ability to use dynamic methods like add_<type> (ex: add_win)
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
      # sorting by score
      score_ordering = another_player.score <=> score
      # sorting by goal average if same score
      if score_ordering == 0
        score_ordering = another_player.goal_average <=> goal_average
      end
      # sorting by name if score and goal average same
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
