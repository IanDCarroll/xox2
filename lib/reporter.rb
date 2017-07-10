require 'game_constants'

class Reporter

  def initialize
    @const = GameConstants.new
  end

  def report(status)
    winning_player = check_for_win(status[:board])
    if winning_player
      return @const.winner(winning_player)
    elsif not empty_spaces?(status[:board])
      return @const.draw
    end
    report_move(status)
  end

  def report_move(status)
    if status[:space].nil? then return nil end
    [ status[:board][status[:space]], status[:space] ]
  end

  def check_for_win(board)
    @const.winning_sets.each do |winning_set|
      winning_mark = winning_set(board, winning_set)
      if winning_mark then return winning_mark end
    end
    false
  end

  def winning_set(board, winning_set)
    win = []
    winning_set.each { |space| win << board[space] }
    unless win.uniq[0].nil? || win.uniq[0].instance_of?(Integer) 
      if win.uniq.length == 1
        return win.uniq.first end
    end
  end

  def empty_spaces?(board)
    (0...board.length).each { |i|
      if board[i].nil? || board[i].instance_of?(Integer)

        return true
      end }
    false
  end
end
