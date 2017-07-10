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

  def choose
    optimum_choice
  end

  def optimum_choice(board = @board, depth = 0, choices = {})
    report = @judge.report({board: board.spaces})
    if report == @const.draw then return 0 
    elsif report == @const.winner(@const.players[1]) then return 1
    elsif report == @const.winner(@const.players[0]) then return -1 end

    board.available_spaces.each do |space|
      board.mark(space, appropriate_player)
      choices[space] = optimum_choice(board, depth + 1, {})
      board.mark(space, nil)
    end

    @choices = choices
    optimal_space = choices.max_by { |space, score| score }[0]
    depth == 0 ? optimal_space : optimal_score(choices, depth)
  end

  attr_reader :choices

  def optimal_score(choices, depth)
    min = choices.min_by { |space, score| score }[1]
    max = choices.max_by { |space, score| score }[1]
    depth.odd? ? min : max
  end

  def appropriate_player # this needs to go in the board class
                         # or maybe in the rules class
                         # if rules, then rules needs to inherit board
                         # and rules needs to be passed into AI & Minimax
    spaces_taken = @board.spaces.length - @board.available_spaces.length
    spaces_taken.odd? ? @const.players[1] : @const.players[0]
  end
end
