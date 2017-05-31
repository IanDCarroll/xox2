class Board
  attr_reader :spaces

  def initialize
    @spaces = []
    (1..9).each do |i| @spaces << i.to_s end
  end

  def mark(player_mark, space)
    @spaces[space] = player_mark
  end

  def size
    @spaces.length
  end
end
