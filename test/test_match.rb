require 'test/unit'

require 'league/player'
require 'league/match'

include League

class TestMatch < Test::Unit::TestCase

  def setup
    @player_1 = Player.new('JoJoS', 'Juri')
    @player_2 = Player.new('Weak', 'Yang')

    @match = Match.new(@player_1, @player_2)
  end
  
  def test_score_1
    @match.score_1 = 2
    assert_equal(2, @match.score_1)
  end
  
  def test_score_2
    @match.score_2 = 2
    assert_equal(2, @match.score_2)
  end
  
  def test_player_1_win
    @match.player_1_win
    assert_equal(@player_1, @match.winner)
  end
  
  def test_player_2_win
    @match.player_2_win
    assert_equal(@player_2, @match.winner)
  end
  
  def test_finished
    refute(@match.finished?)
    
    @match.player_1_win
    assert(@match.finished?)
  end
  
  def test_equal  
    match1 = Match.new(@player_1, @player_2)
    match2 = Match.new(@player_1, Player.new('Ryugan'))
    match3 = Match.new(@player_1, @player_2)
    match4 = Match.new(Player.new('JoJoS'), @player_2)
    
    refute_equal(match1, match2)
    refute_equal(match2, match3)
    assert_equal(match1, match3)
    assert_equal(match3, match4)
  end
  
end
