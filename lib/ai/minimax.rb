require "game_constants"
require "reporter"

class Minimax
  attr_reader :spaces
  attr_accessor :recursion_depth

  def initialize(board)
    @const = GameConstants.new
    @judge = Reporter.new
    @board = board.dup
    @spaces = @board.spaces
    @recursion_depth = 0
  end

  def choose #first available to validate integration
    @board.available_spaces[0]
  end

  def available_spaces
    @board.available_spaces
  end

# recursion dependent ==v









  def appropriate_player
    @recursion_depth.odd? ? @const.players[1] : @const.players[0]
  end
end
