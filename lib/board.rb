class Board
  attr_reader :spaces

  def initialize
    @spaces = []
    @empty_space = ""
    9.times do @spaces << @empty_space end
  end

  def mark(player_mark, space)
    @spaces[space] = player_mark
  end
end
