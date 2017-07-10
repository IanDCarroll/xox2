require 'reporter'
require 'game_constants'

class Rules

  def initialize(board)
    @reporter = Reporter.new
    @const = GameConstants.new
    @board = board
    @player = @const.players
    @current_player = @player[1]
  end

  def mark(space)
    swap_players
    @board.mark(space, @current_player)
    @reporter.report(status(space))
  end

  def swap_players
    if @current_player == @player[0]
      return @current_player = @player[1]
    end
    @current_player = @player[0]
  end

  def status(space)
    { space: space, 
      board: @board.spaces }
  end

  def reset
    @board.reset_marks
    @current_player = @player[1]
  end
end
