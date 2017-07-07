require 'spec_helper'
require 'rspec-given'
require 'ai/minimax'
require 'board'
require 'game_constants'


describe 'Minimax board' do
  context 'when a new board is passed to Minimax' do
    Given(:board) { Board.new }
    When(:minimax) { Minimax.new(board) }
    Then { Array.new(9) == minimax.spaces }
  end

  context 'when a new board passed to Minimax is updated' do
    Given(:board) { Board.new }
    When(:minimax) { Minimax.new(board) }
    When { board.mark(4,"X")}
    Then { [nil,nil,nil,
            nil,"X",nil,
            nil,nil,nil] == minimax.spaces }
  end
end

describe 'Minimax appropriate_player' do
  context 'when depth is at the root level' do
    Given(:const) { GameConstants.new }
    Given(:minimax) { Minimax.new(Board.new) }
    Given(:depth) { 0 }
    Then { const.players[1] == minimax.appropriate_player(depth) }
  end

  context 'when depth is an odd number' do
    Given(:const) { GameConstants.new }
    Given(:minimax) { Minimax.new(Board.new) }
    Given(:depth) { 1 }
    Then { const.players[0] == minimax.appropriate_player(depth) }
  end

  context 'when depth is an even number' do
    Given(:const) { GameConstants.new }
    Given(:minimax) { Minimax.new(Board.new) }
    Given(:depth) { 0 }
    Then { const.players[1] == minimax.appropriate_player(depth) }
  end

end

## = checked
# = unchecked

describe "Minimax optimum_choice" do
  context 'when the board is drawn' do
    Given(:board) { Board.new }
    Given(:minimax) { Minimax.new(board) }
    When { board.mark(8, "X")
           board.mark(0, "O")
           board.mark(1, "X")
           board.mark(2, "O")
           board.mark(4, "X")
           board.mark(3, "O")
           board.mark(5, "X")
           board.mark(7, "O")
           board.mark(6, "X") } 
    Then { 0 == minimax.optimum_choice }
  end

  context 'when the board is lost at the last move' do
    Given(:board) { Board.new }
    Given(:minimax) { Minimax.new(board) }
    When { board.mark(1, "X")
           board.mark(4, "O")
           board.mark(2, "X")
           board.mark(5, "O")
           board.mark(3, "X")
           board.mark(7, "O")
           board.mark(6, "X")
           board.mark(8, "O")
           board.mark(0, "X") } 
    Then { -1 == minimax.optimum_choice }
  end

  context 'when the board is lost early' do
    Given(:board) { Board.new }
    Given(:minimax) { Minimax.new(board) }
    When { board.mark(0, "X")
           board.mark(8, "O")
           board.mark(1, "X")
           board.mark(7, "O")
           board.mark(2, "X") } 
    Then { -1 == minimax.optimum_choice }
  end

   context 'when the board is won early' do
    Given(:board) { Board.new }
    Given(:minimax) { Minimax.new(board) }
    When { board.mark(0, "X")
           board.mark(8, "O")
           board.mark(1, "X")
           board.mark(7, "O")
           board.mark(4, "X") 
           board.mark(6, "O") }
    Then { 1 == minimax.optimum_choice }
  end 

##  context 'when there is only one move left which wins' do
##    Given(:board) { Board.new }
##    Given(:minimax) { Minimax.new(board) }
##    When { board.mark(8, "X")
##           board.mark(0, "O")
##           board.mark(1, "X")
##           board.mark(2, "O")
##           board.mark(4, "X")
##           board.mark(3, "O")
##           board.mark(5, "X")
##           board.mark(7, "O") } 
##    Then { 6 == minimax.optimum_choice }
##  end
##
##  context 'when there are two moves left and one wins' do
##    Given(:board) { Board.new }
##    Given(:minimax) { Minimax.new(board) }
##    When { board.mark(8, "X")
##           board.mark(0, "O")
##           board.mark(1, "X")
##           board.mark(2, "O")
##           board.mark(4, "X")
##           board.mark(3, "O")
##           board.mark(5, "X") }
##    Then { 6 == minimax.optimum_choice }
##  end
##
##   context 'when there are two moves left and one loses' do
##    Given(:board) { Board.new }
##    Given(:minimax) { Minimax.new(board) }
##    When { board.mark(1, "X")
##           board.mark(2, "O")
##           board.mark(4, "X")
##           board.mark(7, "O")
##           board.mark(5, "X")
##           board.mark(8, "O")
##           board.mark(6, "X") }
##    Then { 3 == minimax.optimum_choice }
##  end
##
##   context 'when there are two moves left and both draw' do
##    Given(:board) { Board.new }
##    Given(:minimax) { Minimax.new(board) }
##    When { board.mark(1, "X")
##           board.mark(0, "O")
##           board.mark(3, "X")
##           board.mark(4, "O")
##           board.mark(6, "X")
##           board.mark(7, "O")
##           board.mark(8, "X") }
##    Then { 2 == minimax.optimum_choice }
##  end
##
##  context 'when there are two moves left, one win, one loss' do
##    Given(:board) { Board.new }
##    Given(:minimax) { Minimax.new(board) }
##    When { board.mark(0, "X")
##           board.mark(4, "O")
##           board.mark(1, "X")
##           board.mark(7, "O")
##           board.mark(3, "X")
##           board.mark(8, "O")
##           board.mark(5, "X") }
##    Then { 6 == minimax.optimum_choice }
##  end 
##
  context 'when there is an early chance to win and loose on rows' do
    Given(:board) { Board.new }
    Given(:minimax) { Minimax.new(board) }
    When { board.mark(8, "X")
           board.mark(0, "O")
           board.mark(7, "X")
           board.mark(1, "O")
           board.mark(4, "X") }
    Then { 2 == minimax.optimum_choice }
  end 

#  context 'when there is an early chance to loose and win on rows' do
#    Given(:board) { Board.new }
#    Given(:minimax) { Minimax.new(board) }
#    When { board.mark(0, "X")
#           board.mark(6, "O")
#           board.mark(1, "X")
#           board.mark(7, "O")
#           board.mark(4, "X") }
#    Then { 6 == minimax.optimum_choice }
#  end
#
  context 'when there is an early chance to loose and win on cols' do
    Given(:board) { Board.new }
    Given(:minimax) { Minimax.new(board) }
    When { board.mark(3, "X")
           board.mark(2, "O")
           board.mark(6, "X")
           board.mark(5, "O")
           board.mark(4, "X") }
    Then { 8 == minimax.optimum_choice }
  end

#  context 'when there is an early chance to win and loose on cols' do
#    Given(:board) { Board.new }
#    Given(:minimax) { Minimax.new(board) }
#    When { board.mark(8, "X")
#           board.mark(3, "O")
#           board.mark(5, "X")
#           board.mark(6, "O")
#           board.mark(4, "X") }
#    Then { 0 == minimax.optimum_choice }
#  end
end
