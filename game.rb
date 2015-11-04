class Game
    attr_reader :number
  def initialize
    @number = rand(0..10)
    @guesses = 0
  end

  def guess(guess)
    guess
  end

  def check_guess(guess)
    if @number == guess
      @guesses += 1
      "CORRECT!!! You guessed #{guess}. That was guess number #{@guesses}!"
    elsif guess < @number
      @guesses += 1
      "Incorrect! That's guess number #{@guesses}. The answer is higher!"
    elsif guess > @number
      @guesses += 1
      "Incorrect! That's guess number #{@guesses}. The answer is lower!"
    end
  end

end
