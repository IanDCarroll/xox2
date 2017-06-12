require 'cli/adapter'

class GameRunner

  def initialize(board, rules, adapter)
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
    if @adapter.relay == 'start'
      set_new_game
      return start_game
    end
    @adapter.push_move(exit_command)
  end

  def play(command)
    if command == 'start'
      return set_new_game
    elsif command == 'exit'
      return exit_command
    elsif command == 'error'
      return error_message
    end
    play_report = @rules.mark(command)
    if end_game?(play_report)
      @playing = false
    end
    message_to_shell(play_report)
  end

  def error_message
    message_to_shell(["bad", "move"])
  end

  def end_game?(play_report)
    play_report[1] == "win" || play_report[1] == "draw"
  end

  def exit_command
    @playing = false
    @play_again = false
    message_to_shell(["end", "game"])
  end

  def play_again
    message_to_shell(["play", "again"])
  end

  def set_new_game
    @playing = true
    @rules.reset
    new_game
  end

  def new_game
    message_to_shell(["new", "game"])
  end

  def message_to_shell(message)
    { message: message, 
      board: @board.spaces }
  end
end
