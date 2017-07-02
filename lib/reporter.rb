require 'game_constants'

class Reporter

  def initialize
    @const = GameConstants.new
  end

  def report(status)
    if win?(status[:board])
      return @const.winner(status[:board][status[:space]])
    elsif not empty_spaces?(status[:board])
      return @const.draw
    end
    report_move(status)
  end

  def report_move(status)
    [ status[:board][status[:space]], status[:space] ]
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
    unless win.uniq == [nil] then win.uniq.length == 1 end
  end

  def empty_spaces?(board)
    (0...board.length).each { |i|
      if board[i] == nil
        return true
      end }
    false
  end
end
