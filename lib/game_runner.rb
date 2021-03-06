require 'game_constants'
require 'cli/adapter'
require 'ai/computer_player'

class GameRunner

  def initialize(board, rules, adapter)
    @const = GameConstants.new
    @board = board
    @rules = rules

    @human_interface = adapter
    @hi = @human_interface
    @hi.push_status(new_game)

    @artificial_intelligence = ComputerPlayer.new(@board)
    @ai = @artificial_intelligence

    @playing = true
    @play_again = true
    @play_report = [ @const.players[1] ]
  end

  def new_game
    message_to_shell(@const.new_game)
  end

  def message_to_shell(message)
    { message: message, 
      board: @board.spaces }
  end

  def start_game
    while @playing
      @hi.display_status(make_a_move)
    end
    play_again?
  end

  def make_a_move
      if @play_report[0] != @const.players[0]
        return play(@hi.pull_move)
      end
      play(@ai.pull_move)
  end

  def play(command)
    if special_command(command)
      return special_command(command)
    end
    @play_report = @rules.mark(command)
    if end_game?(@play_report)
      @playing = false
    end
    message_to_shell(@play_report)
  end

  def special_command(command)
    if command == @const.start
      return set_new_game
    elsif command == @const.exit
      return exit_command
    elsif command == @const.error
      return error_message
    end
   false
  end

  def set_new_game
    @playing = true
    @play_report = [ @const.players[1] ]
    @rules.reset
    new_game
  end

  def exit_command
    @playing = false
    @play_again = false
    message_to_shell(@const.end_game)
  end

  def error_message
    message_to_shell(@const.bad_move)
  end

  def end_game?(play_report)
    play_report[1] == @const.win || play_report == @const.draw
  end

  def play_again?
    if @play_again
      @hi.display_status(play_again)
      reset_game?
    end
  end

  def play_again
    message_to_shell(@const.play_again)
  end

  def reset_game?(answer = @hi.relay)
    if answer == @const.start
      set_new_game
      return start_game
    end
    @hi.display_status(exit_command)
  end
end
