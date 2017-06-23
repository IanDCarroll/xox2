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
    @board = board
    evaluate_choices
    pick_the_best_choice
  end

  def evaluate_choices
    available_spaces.each do |space|
      evaluate_choice(space)
    end
  end

  def available_spaces
    array = []
    @board.length.times do |i|
      @board[i] == (i + 1).to_s ? array << i : nil
    end
    array
  end

  def evaluate_choice(space)
    if sim_report(space)[1] == @const.win
      @choices[space] = 1
    elsif sim_report(space) == @const.draw
      @choices[space] = 0
    end
  end

  def sim_report(space)
    sim_board = @board.dup
    sim_board[space] = @max_mark
    @judge.report({ board: sim_board, 
                    player: @max_mark,
                    space: space })
  end

  def pick_the_best_choice
    @choices.each do |choice|
      if choice == 1 then return @choices.index(choice) end
    end
    available_spaces[0]
  end
end
