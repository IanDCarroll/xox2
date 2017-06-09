require 'validator'
require 'style'

class Adapter

  def initialize(game_runner)
    @game_runner = game_runner
    @judge = Validator.new
    @style = Style.new
    @status = @game_runner.play("start")
  end

  def relay(user_input)
    if @judge.command?(user_input)
      @status = @game_runner.play(user_input)
      return { message: format(@status[:user_message]),
               command: [ @status[:continue_game?],
                          @status[:play_again?] ] }
    end
    choice = parse(user_input)
    if @judge.valid?(@status[:board], choice)
      @status = @game_runner.play(choice)
      return { message: format(@status[:user_message]),
               command: [ @status[:continue_game?],
                          @status[:play_again?] ] }
    end
    @judge.error_message
  end

  def render
    rows = []
    (0...board_size).step(3) do |i| rows << render_row(i) end
    rows.join(@style.shelf) 
  end

private

  def render_row(index)
    row = @status[:board][index..index + 2].join(@style.wall)
    padding = Array.new(2, @style.padding)
    padding.join(row)
  end

  def parse(user_input)
    user_input.to_i - 1
  end

  def board_size
    @status[:board].length
  end

  def format(array)
    if array[1] == "draw"
      return format_draw
    elsif array[1] == "win"
      return format_win(array)
    elsif array == ["new", "game"]
      return format_new
    elsif array == ["end", "game"]
      return format_end
    end
    format_move(array)
  end

  def format_move(array)
    array[1] += 1
    array.join(@style.move_message)
  end

  def format_win(array)
    array[0] + @style.win_message
  end

  def format_draw
    @style.draw_message
  end

  def format_new
    @style.new_game_message
  end

  def format_end
    @style.end_game_message
  end
end
