class Style
  attr_reader :wall
  attr_reader :shelf
  attr_reader :padding
  attr_reader :move
  attr_reader :draw
  attr_reader :win
  attr_reader :new_game
  attr_reader :end_game
  attr_reader :play_again
  attr_reader :farewell
  attr_reader :error
  attr_reader :prompt

  def initialize
    @wall = " | "
    @shelf = "\n---+---+---\n"
    @padding = " "
    @move = " takes square "
    @draw = "The game is a draw."
    @win = " wins the game!"
    @new_game = "new game"
    @end_game = "Thanks for playing!"
    @play_again = "Type \"start\" to play again."
    @farewell = "Thanks for playing!"
    @error = "please choose an available square"
    @prompt = "> "
  end
end
