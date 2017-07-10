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
    elsif report then return -1 end

    @board.available_spaces.each do |space|
      @board.mark(space, appropriate_player)
      choices[space] = -1 * optimum_choice(@spaces, depth + 1, {})
      @board.mark(space, nil)
    end

    @choices = choices
    p @choices
    optimal_space = choices.max_by { |space, score| score }[0]
    depth == 0 ? optimal_space : optimal_score(choices, depth)
  end

  attr_reader :choices

  def readout(depth, choices, min_or_max)
    p appropriate_player + " : " + choices.to_s + " : " + min_or_max
  end

  def optimal_score(choices, depth)
    min = choices.min_by { |space, score| score }[1]
    max = choices.max_by { |space, score| score }[1]
    only = choices.first[1]
    if depth == 1 then p readout(depth, choices, 'min1') ; return min
    elsif depth == 2 then p readout(depth, choices, 'max2'); return max
    elsif depth == 3 then p readout(depth, choices, 'only3'); return only
    #elsif depth == 4 then p readout(depth, 'max4'); return max
    #elsif depth == 5 then p readout(depth, 'only5'); return only
    else raise StandardError, "exceeded recursion depth " + depth.to_s end
  end

  def appropriate_player # this needs to go in the board class
                         # or maybe in the rules class
                         # if rules, then rules needs to inherit board
                         # and rules needs to be passed into AI & Minimax
    spaces_taken = @board.spaces.length - @board.available_spaces.length
    spaces_taken.odd? ? @const.players[1] : @const.players[0]
  end
end
