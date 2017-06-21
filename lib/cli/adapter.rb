require 'cli/imperative_shell'
require 'cli/validator'
require 'cli/style'
require 'cli/message_formatter'
require 'cli/board_constructor'
require 'game_constants'

class Adapter

  def initialize(shell = ImperativeShell.new)
    @shell = shell
    @judge = Validator.new
    @style = Style.new
    @const = GameConstants.new
    @message_formatter = MessageFormatter.new
    @board_constructor = BoardConstructor.new
    @status = {}
    @previous_board = []
  end

  def pull_move
    display_board
    relay
  end

  def display_board
    if render_board != @previous_board
      @previous_board = render_board
      @shell.display(render_board)
    end
  end

  def render_board
    @board_constructor.construct(@status[:board])
  end

  def relay(user_input = @shell.get_user_input)
    if @judge.command?(user_input)
      return user_input
    end
    @judge.valid?(@status[:board], user_input)
  end

  def display_status(message)
    push_status(message)
    display_message
    display_board
  end

  def push_status(status)
    @status = status
  end

  def display_message
    @shell.display(format_message)
  end

  def format_message
    @message_formatter.format(@status[:message])
  end
end
