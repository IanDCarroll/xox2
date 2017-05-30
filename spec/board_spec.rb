require 'rspec-given'
require 'board'

describe 'Board init' do
  Given(:board) { Board.new }
  Then { raise_error != board }
end

describe 'Board spaces' do
  context 'when the board starts' do
    Given(:board) { Board.new }
    Then { [ "1", "2", "3", 
             "4", "5", "6", 
             "7", "8", "9" ] == board.spaces }
  end
end

describe 'Board mark' do
  context 'when player 1 makes a move' do
    Given(:board) { Board.new }
    When(:change) { board.mark("X", 5) }
    Then { [ "1", "2", "3",
             "4", "5", "X",
             "7", "8", "9" ] == board.spaces }
  end

  context 'when player 2 makes a move after player 1' do
    Given(:board) { Board.new }
    When(:change2) { board.mark("X", 5) 
                     board.mark("O", 1) }
    Then { [ "1", "O", "3",
             "4", "5", "X",
             "7", "8", "9" ] == board.spaces }
  end
end
