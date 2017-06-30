class Minimax
  attr_reader :spaces

  def initialize(board)
    @board = board.dup
    @spaces = @board.spaces
  end
end
