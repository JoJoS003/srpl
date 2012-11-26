require 'test/unit'

require 'srpl/player'
require 'srpl/match'
require 'srpl/round'

include SRPL

class TestRound < Test::Unit::TestCase

  def setup
    @p1 = Player.new 'JoJoS'
    @p2 = Player.new 'Weak'
    @p3 = Player.new 'Ryugan'
    @p4 = Player.new 'Sephiyo'

    @m1 = Match.new @p1, @p2
    @m2 = Match.new @p2, @p3
    @m3 = Match.new @p1, @p3
    @m4 = Match.new @p2, @p4
    
    @round1 = Round.new('round1', [@m1, @m2, @m3])
  end
  
  def test_each
    assert_respond_to(@round1,:count)
    assert_equal(3, @round1.count)
    @round1.each do |match|
      assert(@round1.include?(match))
    end
  end
  
end
