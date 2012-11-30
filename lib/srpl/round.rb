require 'srpl/player'
require 'srpl/match'
require 'srpl/matchs_container'

module SRPL

  class Round
    
    include Enumerable
    include MatchsContainer
    
    attr_accessor :name, :matchs
    
    def initialize(name = '', matchs = [])
      @name = name
      @matchs = matchs
    end
    
    def each(&block)
      @matchs.each { |m| yield m }
    end
    
    def <<(match)
      @matchs << match
    end
    
  end
  
end

