require 'cli/style'
require 'game_constants'

class MessageFormatter

  def initialize
    @style = Style.new
    @const = GameConstants.new
  end

  def format(message_array)
    move = message_array[1]
    if move == @const.win
      return format_win(message_array)
    elsif message_array == @const.draw
      return @style.draw
    elsif message_array == @const.new_game
      return @style.new_game
    elsif message_array == @const.end_game
      return @style.end_game
    elsif message_array == @const.bad_move
      return @style.error
    elsif message_array == @const.play_again
      return @style.play_again
    end
    format_move(message_array)
  end

  def format_win(message_array)
    winning_player = message_array[0]
    winning_player + @style.win
  end

  def format_move(message_array)
    index_offset = 1
    message_array[1] += index_offset
    message_array.join(@style.move)
  end
end
