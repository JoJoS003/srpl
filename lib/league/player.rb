require 'league/rules'

module League

  class Player
    
    attr_reader :name, :wins, :defeats, 
      :desertions, :opponent_desertions

    def initialize(infos = {})
      @name = infos[:name] ? infos[:name] : ''
      @wins = infos[:wins] ? infos[:wins].to_i : 0
      @defeats = infos[:defeats] ? infos[:defeats].to_i : 0
      @desertions = infos[:desertions] ? infos[:desertions].to_i : 0
      @opponent_desertions = infos[:opponent_desertions] ? infos[:opponent_desertions].to_i : 0
    end

    def score
      @wins * WIN_POINTS + @defeats * DEFEAT_POINTS + @desertions * DESERTION_POINTS + @opponent_desertions * OPPONENT_DESERTION_POINTS
    end

    def method_missing(method_name, *args, &block)
      if(/^add_(?<attribute>\w+)$/ =~ method_name)
        instance_variable_set("@#{attribute}", instance_variable_get("@#{attribute}") + 1) 
      else
        super
      end
    end

  end

end
