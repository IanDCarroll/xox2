require 'game_constants'

class Validator
  attr_reader :error_message

  def initialize
    @const = GameConstants.new
    @exit = @const.exit
    @start = @const.start
  end

  def command?(string)
    if @exit == string
      return @exit
    elsif @start == string
      return @start
    end
    false
  end

  def valid?(board, choice)
    if not_taken?(board, choice) && not_out_of_bounds?(board, choice)
      return choice
    end
    false
  end

  def not_taken?(board, choice)
    board[choice].to_i == choice + 1
  end

  def not_out_of_bounds?(board, choice)
    choice.between?(0, board.length)
  end
end
