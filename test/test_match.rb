require 'test/unit'

require 'league/player'
require 'league/match'

include League

class TestMatch < Test::Unit::TestCase

  def setup
    @player_1 = Player.new('JoJoS', 'Juri')
    @player_2 = Player.new('Weak', 'Yang')
  end
  
  def test_score_1
    match = Match.new(@player_1, @player_2)
    
    match.score_1 = 2
    assert_equal(2, match.score_1)
  end
  
  def test_score_2
    match = Match.new(@player_1, @player_2)
    
    match.score_2 = 2
    assert_equal(2, match.score_2)
  end
  
  def test_player_1_win
    match = Match.new(@player_1, @player_2)
    
    match.player_1_win
    assert_equal(@player_1, match.winner)
  end
  
  def test_player_2_win
    match = Match.new(@player_1, @player_2)
    
    match.player_2_win
    assert_equal(@player_2, match.winner)
  end
  
  def test_finished
    match = Match.new(@player_1, @player_2)
    
    assert(match.finished? == false)
    
    match.player_1_win
    assert(match.finished? == true)
  end
  
end
