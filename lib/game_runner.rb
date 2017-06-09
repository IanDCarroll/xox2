class GameRunner

  def initialize(board, rules)
    @board = board
    @rules = rules
  end

  def play(command)
    if command == 'start'
      return set_new_game
    elsif command == 'exit'
      return exit_command
    end
    message_to_shell(@rules.mark(command))
  end

  def exit_command
    message_to_shell(["exit", "game"], false)
  end

  def set_new_game
    @rules.reset
    message_to_shell(["new", "game"])
  end

  def message_to_shell(message, will_to_live = true)
    if message[1] == "draw" || message[1] == "win"
      will_to_live = false
    end
    { continue_game?: will_to_live,
      user_message: message, 
      board: @board.spaces }
  end
end
