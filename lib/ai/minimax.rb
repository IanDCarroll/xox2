require "game_constants"
require "reporter"

class Minimax
  attr_reader :spaces
  attr_accessor :depth

  def initialize(board)
    @const = GameConstants.new
    @judge = Reporter.new
    @board = board.dup
    @spaces = @board.spaces
    @depth = 0
  end

  def choose #first available to validate integration
    @board.available_spaces[0]
  end

  def optimum_choice(spaces = @spaces, depth = @depth, choices = {})
    report = @judge.report({board: spaces})
    if report == @const.draw then return 0 
    elsif report == @const.winner(@const.players[0]) then return -1
    elsif report == @const.winner(@const.players[1]) then return 1 end

    @board.available_spaces.each { |space| choices = space }
    choices

  end

  def available_spaces
    @board.available_spaces
  end

  def appropriate_player
    @depth.odd? ? @const.players[1] : @const.players[0]
  end
end
