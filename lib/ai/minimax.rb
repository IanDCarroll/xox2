class Minimax
  attr_reader :spaces

  def initialize(board)
    @board = board
    @spaces = @board.spaces
  end

  def choose #first available to validate integration
    @board.available_spaces[0]
  end
end
