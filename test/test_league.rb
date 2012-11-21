require 'test/unit'

require 'srpl/player'
require 'srpl/match'
require 'srpl/league'

require 'pp'

include SRPL

class TestLeague < Test::Unit::TestCase

  def setup
    @p1 = Player.new 'JoJoS'
    @p2 = Player.new 'Weak'
    @p3 = Player.new 'Ryugan'
    @p4 = Player.new 'Sephiyo'

    @m1 = Match.new @p1, @p2
    @m2 = Match.new @p2, @p3
    @m3 = Match.new @p1, @p3
    @m4 = Match.new @p2, @p4
  end

  def test_match
    league = League.new @p1, @p2, @p3, @p4

    league.instance_exec([@m1, @m2, @m3, @m4]) do |matchs|
      @matchs.concat(matchs)
    end
    
    assert_includes(league.find_match(@p1, @p2), @m1)
    assert_includes(league.find_match(@p2, @p3), @m2)
    assert_includes(league.find_match(@p4, @p2), @m4)
    refute_includes(league.find_match(@p1, @p2), @m2)
  end
  
  def test_find_match_by_player
    
  end
  
  def test_generate_matchs
    league = League.new @p1, @p2, @p3
    assert_equal(3, league.matchs.count)
    league.add_player(@p4)
    assert_equal(6, league.matchs.count)
  end
  
end
