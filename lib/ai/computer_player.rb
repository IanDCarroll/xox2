require 'ai/minimax'

class ComputerPlayer

  def initialize(board)
    @board = board.dup
    @ai = Minimax.new(@board)
  end

  def pull_move
    @ai.choose
  end
end
