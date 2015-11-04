require 'minitest/autorun'
require_relative 'game'

class GameTest < Minitest::Test

  def test_correct_guess
    g = Game.new
    assert_equal "CORRECT!!! You guessed #{g.number}. That was guess number 1!", g.check_guess(g.number)
  end

  def test_incorrect_high_guess
    g = Game.new
    assert_equal "Incorrect! That's guess number 1. The answer is lower!", g.check_guess(11)
  end

  def test_incorrect_low_guess
    g = Game.new
    assert_equal "Incorrect! That's guess number 1. The answer is higher!", g.check_guess(-1)
  end

  def test_guess_counter
    g = Game.new
    g.check_guess(11)
    g.check_guess(12)
    g.check_guess(13)
    assert_equal "Incorrect! That's guess number 4. The answer is lower!", g.check_guess(11)

  end

end
