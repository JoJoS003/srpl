require 'test/unit'

require 'srpl/player'
require 'srpl/match'

include SRPL

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
    @match.player_1_win!
    assert_equal(@player_1, @match.winner)
  end
  
  def test_player_2_win
    @match.player_2_win!
    assert_equal(@player_2, @match.winner)
  end
  
  def test_finish
    @match.finish!(@player_1, 5, 2)
    assert_equal(@player_1, @match.winner)
    assert_equal(5, @match.score_1)
    assert_equal(2, @match.score_2)
    @match.finish!(@player_2, 5, 2)
    assert_equal(@player_2, @match.winner)
    assert_equal(5, @match.score_2)
    assert_equal(2, @match.score_1)
  end
  
  def test_finished
    refute(@match.finished?)
    
    @match.player_1_win!
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
  
  def test_player
    match1 = Match.new(@player_1, @player_2)
    match2 = Match.new(@player_1, Player.new('Ryugan'))
    
    assert(match1.player?(@player_1))
    assert(match1.player?(@player_2))
    assert(match2.player?('Ryugan'))
    refute(match2.player?(@player_2))
  end
  
  def test_desertion
    refute(@match.desertion?)
    @match.finish! 1, 0, 0
    assert(@match.desertion?)
  end
  
  def test_deserted_player
    assert_nil(@match.deserted_player)
    @match.finish! 1, 0, 0
    assert_equal(@player_2, @match.deserted_player)
  end
  
end
