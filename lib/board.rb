class Board
  attr_reader :spaces
  attr_reader :size

  def initialize(size = 9)
    @size = size
    @spaces = Array.new(size)
    paint_numbers_over_spaces
  end

  def mark(player_mark, space)
    @spaces[space] = player_mark
  end

  def paint_numbers_over_spaces
    (0..@size).each do |i| @spaces[i - 1] = i.to_s  end
  end
end
