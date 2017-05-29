require_relative 'board'

class XoxGame
  attr_reader :board

  def initialize(board = Board.new)
    @board = board.spaces
  end

end
