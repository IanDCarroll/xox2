require 'rspec-given'
require 'adapter'
require 'rules'
require 'board'

describe 'Adapter init' do
  Given(:board) { Board.new}
  Given(:subject) { Adapter.new(board, Rules.new(board)) }
  Then { raise_error != subject } 
end

describe 'Adapter render' do
  context 'when render renders the first board' do
    Given(:board) { Board.new}
    Given(:subject) { Adapter.new(board, Rules.new(board)) }
    Then { expect(subject.render).to be_a(String) }
    And  { " 1 | 2 | 3 \n---+---+---\n 4 | 5 | 6 \n---+---+---\n 7 | 8 | 9 " == subject.render }
  end
end

describe 'Adapter relay' do
  context 'when relay passes information from the shell to the core' do
    Given(:board) { Board.new}
    Given(:adapter) { Adapter.new(board, Rules.new(board)) }
    When { adapter.relay("5") }
    Then { " 1 | 2 | 3 \n---+---+---\n 4 | X | 6 \n---+---+---\n 7 | 8 | 9 "== adapter.render }
  end

  context 'when relay passes additional info from the shell to the core' do
    Given(:board) { Board.new}
    Given(:adapter) { Adapter.new(board, Rules.new(board)) }
    When { adapter.relay("5") 
           adapter.relay("1") }
    Then { " O | 2 | 3 \n---+---+---\n 4 | X | 6 \n---+---+---\n 7 | 8 | 9 "== adapter.render }
  end

  context 'when format is passed a move message' do
    Given(:board) { Board.new}
    Given(:adapter) { Adapter.new(board, Rules.new(board)) }
    When(:subject) { adapter.relay(5) }
    Then { "X takes square 5" == subject }
  end

  context 'when format is passed a different move message' do
    Given(:board) { Board.new}
    Given(:adapter) { Adapter.new(board, Rules.new(board)) }
    When(:subject) { adapter.relay("5") 
                     adapter.relay("1") }
    Then { "O takes square 1" == subject }
  end

  context 'when format is passed a draw message' do
    Given(:drawn_game) { [ "5", "1", "9", "7", "4", "6", "8", "2", "3" ] }
    Given(:board) { Board.new}
    Given(:adapter) { Adapter.new(board, Rules.new(board)) }
    Given { (0..7).each do |i| adapter.relay(drawn_game[i]) end}
    When(:subject) { adapter.relay(drawn_game[8]) }
    Then { "The game is a draw." == subject }
  end

  context 'when format is passed a win message' do
    Given(:won_game) { [ "5", "2", "1", "9", "7", "4", "3" ] }
    Given(:board) { Board.new}
    Given(:adapter) { Adapter.new(board, Rules.new(board)) }
    Given { (0..5).each do |i| adapter.relay(won_game[i]) end}
    When(:subject) { adapter.relay(won_game[6]) }
    Then { "X wins the game!" == subject }
  end

  context 'when format is passed a different win message' do
    Given(:won_game) { [ "2", "5", "8", "1", "9", "7", "3", "4" ] }
    Given(:board) { Board.new}
    Given(:adapter) { Adapter.new(board, Rules.new(board)) }
    Given { (0..6).each do |i| adapter.relay(won_game[i]) end}
    When(:subject) { adapter.relay(won_game[7]) }
    Then { "O wins the game!" == subject }
  end
end
