require_relative 'xox'

class Adapter

  def initialize(game = XoxGame.new)
    @spaces = game.board
    number_empty_spaces
  end

  def render
    shelf = "\n---+---+---\n"
    rows = []
    (0..8).step(3) do |i| rows << render_row(i) end
    rows.join(shelf) 
  end

  def render_row(index)
    wall = " | "
    row = @spaces[index..index + 2].join(wall)
    padding = [" ", " "]
    padding.join(row)
  end

  def number_empty_spaces
    (0..8).each do |i|
      if empty?(i)
        num = i + 1 
        @spaces[i] = num.to_s
      end
    end
  end

  def empty?(space)
    @spaces[space] == ""
  end
end

