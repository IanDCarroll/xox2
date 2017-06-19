class GameConstants
  attr_reader :players
  attr_reader :winning_sets
  attr_reader :draw
  attr_reader :bad_move
  attr_reader :end_game
  attr_reader :play_again
  attr_reader :new_game
  attr_reader :win
  attr_reader :start
  attr_reader :exit
  attr_reader :error

  def initialize
    @players = [ 'X', 'O' ]
    @winning_sets = [ [0,1,2], [3,4,5], [6,7,8], [0,3,6], 
                      [1,4,7], [2,5,8], [0,4,8], [2,4,6] ]
    @win = 'win'
    @draw = ['game', 'draw']
    @bad_move = ['bad', 'move']
    @end_game = ['end', 'game']
    @play_again = ['play', 'again']
    @new_game = ['new', 'game']
    @start = 'start'
    @exit = 'exit'
    @error = 'error'
  end

  def winner(player)
    [ player, @win ]
  end
end
