require 'adapter'

class GameRunner

  def initialize(board, rules, adapter = Adapter.new)
    @board = board
    @rules = rules
    @adapter = adapter
    @playing = true
    @play_again = true
  end

  def start_game
    while @playing
      @adapter.display_board
      @adapter.push_status(play(@adapter.relay))
      @adapter.display_message
    end
    if @play_again
      @adapter.display_board
      @adapter.push_status(play_again)
      @adapter.display_message
      again = @adapter.relay
      if again == 'start'
        set_new_game
        start_game
      else
        @adapter.push_status(exit_command)
        @adapter.display_message
      end
    end
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
