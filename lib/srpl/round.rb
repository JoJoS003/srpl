require 'srpl/player'
require 'srpl/match'

module SRPL

  class Round
    
    include Enumerable
    
    attr_accessor :matchs
    
    def initialize(name = '', matchs = [])
      @name = name
      @matchs = matchs
    end
    
    def each(&block)
      @matchs.each { |m| yield m }
    end
    
  end
  
end

