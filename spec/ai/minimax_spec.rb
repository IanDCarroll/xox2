require 'spec_helper'
require 'rspec-given'
require 'ai/minimax'
require 'board'


describe 'Minimax board functions' do
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
#describe 'Minimax available_moves' do
#  context 'when available moves scans an enpty board' do
#    Given(:) {}
#    When(:) {}
#    Then {}
#  end
#end

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
#
#  context 'when 1 is the only square left' do
#    Given(:board) { [ "X",nil,"O",
#                      "O","X","X",
#                      "X","O","O" ] }
#    When(:minimax) { Minimax.new }
#    When(:choice) { minimax.choose(board) }
#    Then { 1 == choice }
#  end
#
#  context 'when 5 is the only square left' do
#    Given(:board) { [ "X","O","X",
#                      "O","X",nil,
#                      "O","X","O" ] }
#    When(:minimax) { Minimax.new }
#    When(:choice) { minimax.choose(board) }
#    Then { 5 == choice }
#  end
#
#  context 'when 4 is the only square left' do
#    Given(:board) { [ "X","O","X",
#                      "O",nil,"O",
#                      "X","O","X" ] }
#    When(:minimax) { Minimax.new }
#    When(:choice) { minimax.choose(board) }
#    Then { 4 == choice }
#  end
#
#  context 'when 0 is the only square left' do
#    Given(:board) { [ nil,"O","O",
#                      "X","X","O",
#                      "X","O","X" ] }
#    When(:minimax) { Minimax.new }
#    When(:choice) { minimax.choose(board) }
#    Then { 0 == choice }
#  end
#
#  context 'when 2 is the only square left' do
#    Given(:board) { [ "X","X",nil,
#                      "O","X","O",
#                      "X","O","O" ] }
#    When(:minimax) { Minimax.new }
#    When(:choice) { minimax.choose(board) }
#    Then { 2 == choice }
#  end
#
#  context 'when 8 is the only square left' do
#    Given(:board) { [ "X","O","X",
#                      "O","X","X",
#                      "O","O",nil ] }
#    When(:minimax) { Minimax.new }
#    When(:choice) { minimax.choose(board) }
#    Then { 8 == choice }
#  end
#
#  context 'when 6 is the only square left' do
#    Given(:board) { [ "O","O","X",
#                      "O","X","O",
#                      nil,"X","X" ] }
#    When(:minimax) { Minimax.new }
#    When(:choice) { minimax.choose(board) }
#    Then { 6 == choice }
#  end
#
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
