require 'cli/imperative_shell'
require 'cli/validator'
require 'cli/style'
require 'game_constants'

class Adapter

  def initialize(shell = ImperativeShell.new)
    @shell = shell
    @judge = Validator.new
    @style = Style.new
    @const = GameConstants.new
    @status = { board: ["1","2","3","4","5","6","7","8","9"], 
                message: @const.new_game }
    @previous_board = ""
  end

  def pull_move
    display_board
    relay
  end

  def push_move(message)
    push_status(message)
    display_message
    display_board
  end

  def display_message
    @shell.display(format_message)
  end

  def display_board
    if render_board != @previous_board
      @shell.display(render_board)
    end
    @previous_board = render_board
  end

  def relay(user_input = @shell.get_user_input)
    if @judge.command?(user_input)
      return user_input
    end
    choice = input_to_i(user_input)
    if @judge.valid?(@status[:board], choice)
      return choice
    end
    "error"
  end

  def render_board
    rows = []
    (0...board_size).step(3) do |i| rows << render_row(i) end
    rows.join(@style.shelf)
  end

  def format_message
    if @status[:message] == @const.draw
      return @style.draw
    elsif @status[:message][1] == @const.win
      return format_win(@status[:message])
    elsif @status[:message] == @const.new_game
      return @style.new_game
    elsif @status[:message] == @const.end_game
      return @style.end_game
    elsif @status[:message] == @const.error
      return @style.error
    elsif @status[:message] == @const.play_again
      return @style.play_again
    end
    format_move(@status[:message])
  end

  def push_status(status)
    @status = status
  end

private

  def render_row(index)
    row = @status[:board][index..index + 2].join(@style.wall)
    padding = Array.new(2, @style.padding)
    padding.join(row)
  end

  def input_to_i(user_input)
    user_input.to_i - 1
  end

  def board_size
    @status[:board].length
  end

  def format_move(array)
    array[1] += 1
    array.join(@style.move)
  end

  def format_win(array)
    array[0] + @style.win
  end
end
