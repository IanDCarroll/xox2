require 'cli/style'

class BoardConstructor

  def initialize
    @style = Style.new
  end

  def construct(board)
    @board = board
    rows = []
    (0...size).step(square) do |i| rows << construct_row(i) end
    rows.join(@style.shelf)
  end

  def size
    @board.length
  end

  def square
    Math.sqrt(size).to_i
  end

  def construct_row(index)
    row = @board[index...index + square].join(@style.wall)
    padding = Array.new(2, @style.padding)
    padding.join(row)
  end
end
