require 'rspec-given'
require 'rules'
require 'board'

describe 'Rules init' do
  Given(:subject) { Rules.new(Board.new) }
  Then { raise_error != subject }
end

describe 'Rules mark' do
  context 'when a player marks the board' do
    Given(:board) { Board.new }
    Given(:game) { Rules.new(board) }
    When(:subject) { game.mark(4) }
    Then { [ "1","2","3",
             "4","X","6",
             "7","8","9" ] == board.spaces }
  end

  context 'when a player marks the board' do
    Given(:board) { Board.new }
    Given(:game) { Rules.new(board) }
    When(:subject) { game.mark(4) 
                     game.mark(0) }
    Then { [ "O","2","3",
             "4","X","6",
             "7","8","9" ] == board.spaces }
  end
end
