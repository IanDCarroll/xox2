require 'reporter'
require 'game_constants'

class Rules

  def initialize(board)
    @reporter = Reporter.new
    @const = GameConstants.new
    @board = board
    @player = @const.players
    @current_player = @player[1]
    @moves = 0
  end

  def mark(space)
    @moves += 1
    swap_players
    @board.mark(@current_player, space)
    @reporter.report(status(space))
  end

  def swap_players
    if @current_player == @player[0]
      return @current_player = @player[1]
    end
    @current_player = @player[0]
  end

  def status(space)
    { player: @current_player, 
      space: space, 
      moves: @moves, 
      size: @board.size, 
      board: @board.spaces }
  end

  def reset
    @board.paint_numbers_over_spaces
    @moves = 0
    @current_player = @player[1]
  end
end
