require "game_constants"
require "reporter"

class Minimax
  attr_reader :spaces

  def initialize(board)
    @const = GameConstants.new
    @judge = Reporter.new
    @board = board.dup
    @spaces = @board.spaces
  end

  def choose #first available to validate integration
    @board.available_spaces[0]
  end

  def optimum_choice(spaces = @spaces, depth = 0, choices = {})
    report = @judge.report({board: spaces})
    if report == @const.draw then return 0 
    elsif report == @const.winner(@const.players[0]) then return -1
    elsif report == @const.winner(@const.players[1]) then return 1 end

    @board.available_spaces.each do |space|
      @board.mark(space, appropriate_player(depth)) 
      choices[space] = optimum_choice(@spaces, depth + 1, {})
      @board.mark(space, nil)
    end

    optimal_score = choices.max_by { |space, score| score }[1]
    optimal_space = choices.max_by { |space, score| score }[0]
    depth == 0 ? optimal_space : optimal_score
  end

  def appropriate_player(depth)
    depth.odd? ? @const.players[0] : @const.players[1]
  end
end
