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

    p "enter " + depth.to_s
    p @board.available_spaces
    @board.available_spaces.each do |space|
      p spaces
      p "evaluate space " + space.to_s
      @board.mark(space, appropriate_player(depth))
      choices[space] = optimum_choice(@spaces, depth + 1, {})
      p spaces
      p choices
      @board.mark(space, nil)
    end
    p "exit " + depth.to_s

    @choices = choices
    optimal_space = choices.max_by { |space, score| score }[0]
    depth == 0 ? optimal_space : optimal_score(choices, depth)
  end

  attr_reader :choices

  def optimal_score(choices, depth)
    min = choices.min_by { |space, score| score }[1]
    max = choices.max_by { |space, score| score }[1]
    only = choices.first[1]
    if depth == 1 then return min
    elsif depth == 2 then return min
    elsif depth == 3 then return max
    elsif depth == 4 then return only
    elsif depth == 5 then return only
    else raise StandardError, "exceeded recursion depth " + depth.to_s end
  end

  def appropriate_player(depth)
    depth.odd? ? @const.players[0] : @const.players[1]
  end
end
