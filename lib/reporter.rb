require 'game_constants'

class Reporter

  def initialize
    @const = GameConstants.new
  end

  def report(status)
    if endgame(status)
      return endgame(status)
    end
    report_move(status)
  end

  def report_move(status)
    [ status[:player], status[:space] ]
  end

  def endgame(status)
    if win?(status)
      return @const.winner(status[:player])
    elsif out_of_moves?(status)
      return @const.draw
    end
    false
  end

  def out_of_moves?(status)
    status[:moves] >= status[:size]
  end

  def win?(status)
    @const.winning_sets.each do |set|
      if winning_set?(status, set)
        return true
      end
    end
    false
  end

  def winning_set?(status, set)
    win = []
    (0...set.length).each { |i| win << status[:board][set[i]] }
    win.uniq.length == 1
  end
end
