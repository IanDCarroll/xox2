class Style
  attr_reader :wall
  attr_reader :shelf
  attr_reader :padding
  attr_reader :move_message
  attr_reader :draw_message
  attr_reader :win_message
  attr_reader :new_game_message
  attr_reader :end_game_message
  attr_reader :play_again
  attr_reader :farewell
  attr_reader :error
  attr_reader :prompt

  def initialize
    @wall = " | "
    @shelf = "\n---+---+---\n"
    @padding = " "
    @move_message = " takes square "
    @draw_message = "The game is a draw."
    @win_message = " wins the game!"
    @new_game_message = "new game"
    @end_game_message = "Thanks for playing!"
    @play_again = "Type \"start\" to play again."
    @farewell = "Thanks for playing!"
    @error = "please choose an available square"
    @prompt = "> "
  end
end
