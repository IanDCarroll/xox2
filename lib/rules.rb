class Rules

  def initialize(board)
    @board = board
    @player = [ "X", "O" ]
    @current_player = @player[1]
  end

  def mark(space)
    swap_players
    @board.mark(@current_player, space)
  end

  def swap_players
    if @current_player == @player[0]
      return @current_player = @player[1]
    end
    @current_player = @player[0]
  end
end
