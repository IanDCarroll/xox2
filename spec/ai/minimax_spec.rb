require 'spec_helper'
require 'rspec-given'
require 'ai/minimax'

describe 'Minimax init' do
  context 'when Minimax initializes' do
    Given(:minimax) { Minimax.new }
    Then { raise_error != minimax }
  end
end

describe 'Minimax choose' do
  context 'when choose is passed a board that is about to win' do
    Given(:board) { [ "O","X","X",
                      "4","5","6",
                      "X","8","O" ] }
    When(:minimax) { Minimax.new }
    When(:choice) { minimax.choose(board) }
    Then { 4 == choice }
  end

  context 'when choose is passed a different board that is about to win' do
    Given(:board) { [ "O","X","X",
                      "4","5","6",
                      "O","8","X" ] }
    When(:minimax) { Minimax.new.choose(board) }
    Then { 3 == minimax }
  end

  context 'when choose is passed a board where the enemy is about to win' do
    Given(:board) { [ "O","X","X",
                      "4","O","6",
                      "7","8","X" ] }
    When(:minimax) { Minimax.new.choose(board) }
    Then { 5 == minimax }
  end
end

describe 'Minimax available_spaces' do
  context 'when available spaces is passed a board' do
    Given(:board) { [ "O","X","X",
                      "4","5","6",
                      "X","8","O" ] }
    Given(:minimax) { Minimax.new }
    When(:options) { minimax.board = board
                     minimax.available_spaces }
    Then { [ 3, 4, 5, 7 ] == options }
  end

  context 'when available spaces is passed a different board' do
    Given(:board) { [ "O","2","X",
                      "4","5","X",
                      "X","8","O" ] }
    Given(:minimax) { Minimax.new }
    When(:options) { minimax.board = board
                     minimax.available_spaces }
    Then { [ 1, 3, 4, 7 ] == options }
  end
end
#
## may require deletion as the evaluation depth becomes deeper
#describe 'Minimax pick_the_best_choice' do
#  context 'if pick_the_best_choice finds no best choice' do
#    Given(:board) { [ "1","2","3",
#                      "4","5","6",
#                      "7","8","9" ] }
#    Given(:first_available_space) { 0 }
#    When(:minimax) { Minimax.new }
#    When(:choice) { minimax.choose(board) 
#                    minimax.pick_the_best_choice }
#    Then { first_available_space == choice }
#  end
#
#end
