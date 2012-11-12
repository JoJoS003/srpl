require 'test/unit'

require 'league/player'
require 'league/rules'

include League

class TestPlayer < Test::Unit::TestCase
  
  def setup
  end
  
  def test_score
    player = League::Player.new('player')
    
    assert_equal(0, player.score)
    
    player.instance_eval { @wins = 1; @defeats = 0; @desertions = 0; @opponent_desertions = 0 }
    assert_equal(WIN_POINTS, player.score)
    
    player.instance_eval { @wins = 0; @defeats = 1; @desertions = 0; @opponent_desertions = 0 }
    assert_equal(DEFEAT_POINTS, player.score)
    
    player.instance_eval { @wins = 0; @defeats = 0; @desertions = 1; @opponent_desertions = 0 }
    assert_equal(DESERTION_POINTS, player.score)
    
    player.instance_eval { @wins = 0; @defeats = 0; @desertions = 0; @opponent_desertions = 1 }
    assert_equal(OPPONENT_DESERTION_POINTS, player.score)
    
    player.instance_eval { @wins = 1; @defeats = 0; @desertions = 0; @opponent_desertions = 0 }
    assert_equal(WIN_POINTS, player.score)
    
    player.instance_eval { @wins = 3; @defeats = 1; @desertions = 2; @opponent_desertions = 1 }
    assert_equal(3 * WIN_POINTS + 1 * DEFEAT_POINTS + 2 * DESERTION_POINTS + 1 * OPPONENT_DESERTION_POINTS, player.score)
  end
  
  def test_add
    player = League::Player.new('player', wins: 0, defeats: 0, desertions: 0, opponent_desertions: 0)
    
    player.add('win')
    assert_equal(1, player.instance_variable_get('@wins'))
    player.add('defeat')
    assert_equal(1, player.instance_variable_get('@defeats'))
    player.add('desertion')
    assert_equal(1, player.instance_variable_get('@desertions'))
    player.add('opponent_desertion')
    assert_equal(1, player.instance_variable_get('@opponent_desertions'))
    
    player.add_win
    assert_equal(2, player.instance_variable_get('@wins'))
    player.add_defeat
    assert_equal(2, player.instance_variable_get('@defeats'))
    player.add_desertion
    assert_equal(2, player.instance_variable_get('@desertions'))
    player.add_opponent_desertion
    assert_equal(2, player.instance_variable_get('@opponent_desertions'))
  end
  
end

