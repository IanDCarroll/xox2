require_relative 'validator'
require_relative 'style'

class Adapter

  def initialize(board, game)
    @board = board
    @game = game
    @judge = Validator.new
    @style = Style.new
  end

  def relay(user_input)
    choice = parse(user_input)
    if @judge.valid?(@board.spaces, choice)
      @game.mark(choice)
      return ""
    end
    @judge.error_message
  end

  def render
    rows = []
    (0...@board.size).step(3) do |i| rows << render_row(i) end
    rows.join(@style.shelf) 
  end

  def render_row(index)
    row = @board.spaces[index..index + 2].join(@style.wall)
    padding = Array.new(2, @style.padding)
    padding.join(row)
  end

  def parse(user_input)
    user_input.to_i - 1
  end
end
