require 'game_constants'

class Reporter

  def initialize
    @const = GameConstants.new
  end

  def report(status)
    if win?(status[:board])
      return @const.winner(status[:player])
    elsif not empty_spaces?(status[:board])
      return @const.draw
    end
    report_move(status)
  end

  def report_move(status)
    [ status[:player], status[:space] ]
  end

  def win?(board)
    @const.winning_sets.each do |winning_set|
      if winning_set?(board, winning_set)
        return true
      end
    end
    false
  end

  def winning_set?(board, winning_set)
    win = []
    winning_set.each { |space| win << board[space] }
    win.uniq.length == 1
  end

  def empty_spaces?(board)
    (0...board.length).each { |i|
      if board[i] == (i + 1).to_s
        return true
      end }
    false
  end
end
