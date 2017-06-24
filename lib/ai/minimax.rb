require 'game_constants'
require 'reporter'

class Minimax
  attr_writer :board

  def initialize
    @const = GameConstants.new
    @judge = Reporter.new
    @max_mark = @const.players[1]
    @min_mark = @const.players[0]
    @choices = []
  end

  def choose(board)
    recurse_through_game_tree(board)
  end

  def recurse_through_game_tree(board)
    evaluate_choices(board)
    pick_the_best_choice
  end

  def evaluate_choices(board)
    available_spaces(board).each do |space|
      evaluate_choice(board, space)
    end
  end

  def available_spaces(board = @board)
    array = []
    board.length.times do |i|
      board[i] == (i + 1).to_s ? array << i : nil
    end
    array
  end

  def evaluate_choice(board, space)
    if sim_report(board, space)[1] == @const.win
      @choices[space] = 1 # needed max and min value toggling
                          # why does this work without toggling?
                          # is it because inside its own scope 
                          # it always plays the hero? 
                          # So it doesn't need to care about min or max?
    elsif sim_report(board, space) == @const.draw
      @choices[space] = 0
    else
      recurse_through_game_tree(sim_board(board, space)) 
    end
  end

  def sim_report(board, space)
    sim_board = board.dup
    sim_board(sim_board, space)
    @judge.report({ board: sim_board, 
                    player: @max_mark,
                    space: space })
  end

  def sim_board(board, space)
    board[space] = @max_mark
    board
  end

  def pick_the_best_choice
    # should toggle back and forth between min & max depending on depth
    # needed: depth variable for min and max, 
    # but it looks like that's not necessary.
    # why does @choices work? It shouldn't work since its on a global scope
    @choices.each do |choice|
      if choice == 1 then return @choices.index(choice) end
    end
    available_spaces[0]
  end
end
