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

  def score_spaces(spaces = @spaces)
    @recursion_depth += 1
    scored_spaces = spaces
    available_spaces.each do |space|
      scored_spaces[space] = score_space(space)
    end
    @recursion_depth -= 1
    scored_spaces
  end

  def score_space(space)
    scenario = report(space)
    if scenario == @const.winner(@const.players[1]) then return 1
    elsif scenario == @const.winner(@const.players[0]) then return -1 
    elsif scenario == @const.draw then return 0 
    else 2 end
  end

  def report(space)
    @judge.report({ space: space,
                    board: trial_spaces(space) })
  end

  def trial_spaces(space)
    trial_spaces = @spaces.dup
    trial_spaces[space] = appropriate_player
    trial_spaces
  end

  def appropriate_player
    @recursion_depth.odd? ? @const.players[1] : @const.players[0]
  end

# recursion_dependent ==^

  def make_ultimate_choice(scored_spaces)
    ultimate_choice = "no ultimate choice made"
    best_score_so_far = -1
    scored_spaces.each do |space| 
      unless space.instance_of?(String)
        if space >= best_score_so_far
          best_score_so_far = space
          ultimate_choice = scored_spaces.index(space) 
        end
      end
    end
    ultimate_choice
  end
end
