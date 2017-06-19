require 'cli/adapter'
require 'game_constants'

class GameRunner

  def initialize(board, rules, adapter)
    @const = GameConstants.new
    @board = board
    @rules = rules
    @adapter = adapter
    @playing = true
    @play_again = true
  end

  def start_game
    while @playing
      @adapter.push_move(play(@adapter.pull_move))
    end
    play_again?
  end

  def play_again?
    if @play_again
      @adapter.push_move(play_again)
      execute_decision
    end
  end

  def execute_decision
    if @adapter.relay == @const.start
      set_new_game
      return start_game
    end
    @adapter.push_move(exit_command)
  end

  def play(command)
    if command == @const.start
      return set_new_game
    elsif command == @const.exit
      return exit_command
    elsif command == @const.error
      return error_message
    end
    play_report = @rules.mark(command)
    if end_game?(play_report)
      @playing = false
    end
    message_to_shell(play_report)
  end

  def error_message
    message_to_shell(@const.bad_move)
  end

  def end_game?(play_report)
    play_report[1] == @const.win || play_report == @const.draw
  end

  def exit_command
    @playing = false
    @play_again = false
    message_to_shell(@const.end_game)
  end

  def play_again
    message_to_shell(@const.play_again)
  end

  def set_new_game
    @playing = true
    @rules.reset
    new_game
  end

  def new_game
    message_to_shell(@const.new_game)
  end

  def message_to_shell(message)
    { message: message, 
      board: @board.spaces }
  end
end
