class Board
  attr_reader :spaces

  def initialize(size = 9)
    @size = size
    @spaces = Array.new(size)
  end

  def mark(space, player_mark)
    @spaces[space] = player_mark
  end

  def available_spaces
    spaces.map.with_index do |space, ndx|
      ndx if space.nil?
    end.compact
  end

  def erase_marks
    @spaces = Array.new(@size)
  end
end
