class Style
  attr_reader :wall
  attr_reader :shelf
  attr_reader :padding
  attr_reader :move_message
  attr_reader :draw_message
  attr_reader :win_message

  def initialize
    @wall = " | "
    @shelf = "\n---+---+---\n"
    @padding = " "
    @move_message = " takes square "
    @draw_message = "The game is a draw."
    @win_message = " wins the game!" 
  end
end
