require 'test/unit'

require 'league/player'
require 'league/match'
require 'league/league'

include League

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
    @m5 = Match.new @p3, @p4
  end

  def test_match
    league = League.new @p1, @p2, @p3, @p4

    league.instance_eval([@m1, @m2, @m3, @m4]) do |matchs|
      @match.concat(matchs)
    end

    assert_equal(@m1, league.match(@p1, @p2))
    refute_equal(@m2, league_match(@p1, @p2))
  end
end
