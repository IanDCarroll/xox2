require 'game_constants'

class Validator

  def initialize
    @const = GameConstants.new
  end

  def command?(string)
    if @const.exit == string
      return @const.exit
    elsif @const.start == string
      return @const.start
    end
    false
  end

  def valid?(board, raw_choice)
    choice = input_to_i(raw_choice)
    if not_taken?(board, choice) && not_out_of_bounds?(board, choice)
      return choice
    end
    @const.error
  end

  def input_to_i(choice)
    choice.to_i - 1
  end

  def not_taken?(board, choice)
    board[choice] == nil
  end

  def not_out_of_bounds?(board, choice)
    choice.between?(0, board.length - 1)
  end
end
