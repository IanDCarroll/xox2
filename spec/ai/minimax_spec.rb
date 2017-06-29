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
  context 'when 7 is the only square left' do
    Given(:board) { [ "O","O","X",
                      "X","X","O",
                      "O","8","X" ] }
    When(:minimax) { Minimax.new }
    When(:choice) { minimax.choose(board) }
    Then { 7 == choice }
  end

  context 'when 3 is the only square left' do
    Given(:board) { [ "O","X","O",
                      "4","X","O",
                      "X","O","X" ] }
    When(:minimax) { Minimax.new }
    When(:choice) { minimax.choose(board) }
    Then { 3 == choice }
  end

  context 'when 1 is the only square left' do
    Given(:board) { [ "X","2","O",
                      "O","X","X",
                      "X","O","O" ] }
    When(:minimax) { Minimax.new }
    When(:choice) { minimax.choose(board) }
    Then { 1 == choice }
  end

  context 'when 5 is the only square left' do
    Given(:board) { [ "X","O","X",
                      "O","X","6",
                      "O","X","O" ] }
    When(:minimax) { Minimax.new }
    When(:choice) { minimax.choose(board) }
    Then { 5 == choice }
  end

  context 'when 4 is the only square left' do
    Given(:board) { [ "X","O","X",
                      "O","5","O",
                      "X","O","X" ] }
    When(:minimax) { Minimax.new }
    When(:choice) { minimax.choose(board) }
    Then { 4 == choice }
  end

  context 'when 0 is the only square left' do
    Given(:board) { [ "1","O","O",
                      "X","X","O",
                      "X","O","X" ] }
    When(:minimax) { Minimax.new }
    When(:choice) { minimax.choose(board) }
    Then { 0 == choice }
  end

  context 'when 2 is the only square left' do
    Given(:board) { [ "X","X","3",
                      "O","X","O",
                      "X","O","O" ] }
    When(:minimax) { Minimax.new }
    When(:choice) { minimax.choose(board) }
    Then { 2 == choice }
  end

  context 'when 8 is the only square left' do
    Given(:board) { [ "X","O","X",
                      "O","X","X",
                      "O","O","9" ] }
    When(:minimax) { Minimax.new }
    When(:choice) { minimax.choose(board) }
    Then { 8 == choice }
  end

  context 'when 6 is the only square left' do
    Given(:board) { [ "O","O","X",
                      "O","X","O",
                      "7","X","X" ] }
    When(:minimax) { Minimax.new }
    When(:choice) { minimax.choose(board) }
    Then { 6 == choice }
  end

  context 'when one of two squares left will win the game' do
    Given(:board) { [ "O","X","3",
                      "O","X","X",
                      "7","O","X" ] }
    When(:minimax) { Minimax.new }
    When(:choice) { minimax.choose(board) }
    Then { 6 == choice }
  end

#  context 'when another one of two squares left will win the game' do
#    Given(:board) { [ "1","O","O",
#                      "O","X","X",
#                      "X","X","9" ] }
#    When(:minimax) { Minimax.new }
#    When(:choice) { minimax.choose(board) }
#    Then { 0 == choice }
#  end
#
#  context 'when one of three squares left will lose the game' do
#    Given(:board) { [ "O","X","X",
#                      "4","O","6",
#                      "7","8","X" ] }
#    When(:minimax) { Minimax.new }
#    When(:choice) { minimax.choose(board) }
#    Then { 5 == choice }
#  end
#
#  context 'when another one of three squares left will lose the game' do
#    Given(:board) { [ "1","2","O",
#                      "4","O","X",
#                      "X","8","X" ] }
#    When(:minimax) { Minimax.new }
#    When(:choice) { minimax.choose(board) }
#    Then { 7 == choice }
#  end
#
#  context 'when one of four squares left will win the game' do
#    Given(:board) { [ "O","2","X",
#                      "4","X","6",
#                      "O","8","X" ] }
#    When(:minimax) { Minimax.new }
#    When(:choice) { minimax.choose(board) }
#    Then { 3 == choice }
#  end
end
