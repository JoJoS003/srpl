require 'srpl/player'
require 'srpl/match'
require 'srpl/matchs_container'

module SRPL

  class Round
    
    include Enumerable
    include MatchsContainer
    
    attr_accessor :name, :matchs
    attr_accessor :begin, :end
    attr_accessor :stand_off
    
    def initialize(name = '', matchs = [])
      @name = name
      @matchs = matchs
      @stand_off = []
      @begin = nil
      @end = nil
    end
    
    def each(&block)
      @matchs.each { |m| yield m }
    end
    
    def <<(match)
      @matchs << match
    end
    
  end
  
end

