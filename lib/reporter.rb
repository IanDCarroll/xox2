class Reporter

  def initialize
    @winning_sets = [ [0,1,2], [3,4,5], [6,7,8], [0,3,6],
                      [1,4,7], [2,5,8], [0,4,8], [2,4,6] ]
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
      return [ status[:player],  "win" ]
    elsif out_of_moves?(status)
      return [ "game", "draw" ]
    end
    false
  end

  def out_of_moves?(status)
    status[:moves] >= status[:size]
  end

  def win?(status)
    @winning_sets.each do |set|
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
