require 'test/unit'

require 'srpl/player'
require 'srpl/match'
require 'srpl/round'
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
    
    @r1 = Round.new 'r1', [@m1, @m2]
    @r2 = Round.new 'r2', [@m3, @m4]

    @league = League.new @p1, @p2, @p3, @p4
  end
  
  def test_find_player
    assert_send([@league.find_player('JoJoS'), :include?, @p1])
    assert_send([@league.find_player(@p3), :include?, @p3])
  end
  
  def test_match
    @league.instance_exec([@m1, @m2, @m3, @m4]) do |matchs|
      @matchs.concat(matchs)
    end
    
    assert_includes(@league.find_match(@p1, @p2), @m1)
    assert_includes(@league.find_match(@p2, @p3), @m2)
    assert_includes(@league.find_match(@p4, @p2), @m4)
    refute_includes(@league.find_match(@p1, @p2), @m2)
  end
  
  def test_find_match_by_player
    
  end
  
  def test_refresh
    match = @league.find_match_by_players(@p1, @p2)[0]
    match.finish!(@p2, 5, 3)
    @league.refresh
    
    assert_equal(1, @p1.defeats)
    assert_equal(5, @p1.againsts)
    assert_equal(3, @p1.towards)
    assert_equal(1, @p2.wins)
    assert_equal(5, @p2.towards)
    assert_equal(3, @p2.againsts)
  end
  
  def test_generate_matchs
    league = League.new @p1, @p2, @p3
    assert_equal(3, league.matchs.count)
    league.add_player(@p4)
    assert_equal(6, league.matchs.count)
  end
  
  def test_round_index
    @league.rounds << @r1
    @league.rounds << @r2
    
    assert_equal(@r1, @league.round_1)
    assert_equal(@r2, @league.round_2)
  end
  
end
