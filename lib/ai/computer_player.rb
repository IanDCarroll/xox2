require 'ai/minimax'

class ComputerPlayer

  def initialize(board)
    @board = board
    @ai = Minimax.new(board)
  end

  def pull_move
    #@ai.choose # for when it works again
    choose_first_available_move
  end

  def choose_first_available_move
    @board.available_spaces[0]
  end
end
