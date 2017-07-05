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

describe 'Minimax available_spaces' do
  context 'when minimax needs a list of optional moves' do
    Given(:minimax) { Minimax.new(Board.new) }
    Then { [0,1,2,3,4,5,6,7,8] == minimax.available_spaces }
  end

  context 'when the list of available spaces is from a used board' do
    Given(:board) { Board.new }
    Given(:minimax) { Minimax.new(board) }
    When { board.mark(0, "X")
           board.mark(2, "X")
           board.mark(4, "X")
           board.mark(6, "O")
           board.mark(8, "O") }
    Then { [1,3,5,7] == minimax.available_spaces }
  end

   context 'when the list takes integers as not available from a used board' do
    Given(:board) { Board.new }
    Given(:minimax) { Minimax.new(board) }
    When { board.mark(0, 1)
           board.mark(2, 1)
           board.mark(4, 1)
           board.mark(6, 1)
           board.mark(8, 1) }
    Then { [1,3,5,7] == minimax.available_spaces }
  end
end





describe 'Minimax depth' do
  context 'when depth has not been called' do
    Given(:minimax) { Minimax.new(Board.new) }
    Then { 0 == minimax.depth }
  end

  context 'when called to track a deeper recursion' do
    Given(:minimax) { Minimax.new(Board.new) }
    When { minimax.depth += 1 }
    Then { 1 == minimax.depth }
  end

  context 'when called to track a surfacing recursion' do
    Given(:minimax) { Minimax.new(Board.new) }
    Given { minimax.depth += 1 }
    When { minimax.depth -= 1 }
    Then { 0 == minimax.depth }
  end
end

describe 'Minimax appropriate_player' do
  context 'when depth is at the root level' do
    Given(:const) { GameConstants.new }
    Given(:minimax) { Minimax.new(Board.new) }
    When { minimax.depth += 1 }
    Then { const.players[1] = minimax.appropriate_player }
  end

  context 'when recurstion_depth is an even number' do
    Given(:const) { GameConstants.new }
    Given(:minimax) { Minimax.new(Board.new) }
    When { minimax.depth += 1 
           minimax.depth += 1 }
    Then { const.players[0] = minimax.appropriate_player }
  end
end

describe "Minimax optimum_choice" do
  context 'when the method can be called' do
    Given(:board) { Board.new }
    Given(:minimax) { Minimax.new(board) }
    When { 
           board.mark(0, "X")
 } 
    Then { nil == minimax.optimum_choice }
  end
end

#describe 'Minimax choose' do
#  context 'when 7 is the only square left' do
#    Given(:board) { [ "O","O","X",
#                      "X","X","O",
#                      "O",nil,"X" ] }
#    When(:minimax) { Minimax.new }
#    When(:choice) { minimax.choose(board) }
#    Then { 7 == choice }
#  end
#
#  context 'when 3 is the only square left' do
#    Given(:board) { [ "O","X","O",
#                      nil,"X","O",
#                      "X","O","X" ] }
#    When(:minimax) { Minimax.new }
#    When(:choice) { minimax.choose(board) }
#    Then { 3 == choice }
#  end

#  context 'when one of two squares left will win the game' do
#    Given(:board) { [ "O","X",nil,
#                      "O","X","X",
#                      nil,"O","X" ] }
#    When(:minimax) { Minimax.new }
#    When(:choice) { minimax.choose(board) }
#    Then { 6 == choice }
#  end
#
#  context 'when another one of two squares left will win the game' do
#    Given(:board) { [ nil,"O","O",
#                      "O","X","X",
#                      "X","X",nil ] }
#    When(:minimax) { Minimax.new }
#    When(:choice) { minimax.choose(board) }
#    Then { 0 == choice }
#  end
#
#  context 'when one of four squares left will lose the game' do
#    Given(:board) { [ "O","X","X",
#                      nil,"O",nil,
#                      nil,nil,"X" ] }
#    When(:minimax) { Minimax.new }
#    When(:choice) { minimax.choose(board) }
#    Then { 5 == choice }
#  end
#
#  context 'when another one of four squares left will lose the game' do
#    Given(:board) { [ nil,nil,"O",
#                      nil,"O","X",
#                      "X",nil,"X" ] }
#    When(:minimax) { Minimax.new }
#    When(:choice) { minimax.choose(board) }
#    Then { 7 == choice }
#  end
#
#  context 'when one of five squares left will win the game' do
#    Given(:board) { [ "O",nil,"X",
#                      nil,"X",nil,
#                      "O",nil,"X" ] }
#    When(:minimax) { Minimax.new }
#    When(:choice) { minimax.choose(board) }
#    Then { 3 == choice }
#  end
#end
