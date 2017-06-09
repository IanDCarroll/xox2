require 'rspec-given'
require 'adapter'
require 'game_runner'
require 'rules'
require 'board'

describe 'Adapter init' do
  Given(:board) { Board.new}
  Given(:game_runner) { GameRunner.new(board, Rules.new(board))}
  Given(:subject) { Adapter.new(game_runner) }
  Then { raise_error != subject } 
end

describe 'Adapter render' do
  context 'when render renders the first board' do
    Given(:board) { Board.new}
    Given(:game_runner) { GameRunner.new(board, Rules.new(board))}
    Given(:adapter) { Adapter.new(game_runner) }
    When { adapter.relay("start") }
    Then { expect(adapter.render).to be_a(String) }
    And  { " 1 | 2 | 3 \n---+---+---\n 4 | 5 | 6 \n---+---+---\n 7 | 8 | 9 " == adapter.render }
  end
end

describe 'Adapter relay' do
  context 'when relay passes information from the shell to the core' do
    Given(:board) { Board.new}
    Given(:game_runner) { GameRunner.new(board, Rules.new(board))}
    Given(:adapter) { Adapter.new(game_runner) }
    When { adapter.relay("5") }
    Then { " 1 | 2 | 3 \n---+---+---\n 4 | X | 6 \n---+---+---\n 7 | 8 | 9 "== adapter.render }
  end

  context 'when relay passes additional info from the shell to the core' do
    Given(:board) { Board.new}
    Given(:game_runner) { GameRunner.new(board, Rules.new(board))}
    Given(:adapter) { Adapter.new(game_runner) }
    When { adapter.relay("5") 
           adapter.relay("1") }
    Then { " O | 2 | 3 \n---+---+---\n 4 | X | 6 \n---+---+---\n 7 | 8 | 9 "== adapter.render }
  end

  context 'when format is passed a move message' do
    Given(:board) { Board.new}
    Given(:game_runner) { GameRunner.new(board, Rules.new(board))}
    Given(:adapter) { Adapter.new(game_runner) }
    When(:subject) { adapter.relay("5") }
    Then { { message: "X takes square 5",
             command: true }  == subject }
  end

  context 'when format is passed a different move message' do
    Given(:board) { Board.new}
    Given(:game_runner) { GameRunner.new(board, Rules.new(board))}
    Given(:adapter) { Adapter.new(game_runner) }
    When(:subject) { adapter.relay("5") 
                     adapter.relay("1") }
    Then { { message: "O takes square 1",
             command: true } == subject }
  end

  context 'when format is passed a draw message' do
    Given(:drawn_game) { [ "5", "1", "9", "7", "4", "6", "8", "2", "3" ] }
    Given(:board) { Board.new}
    Given(:game_runner) { GameRunner.new(board, Rules.new(board))}
    Given(:adapter) { Adapter.new(game_runner) }
    Given { (0..7).each do |i| adapter.relay(drawn_game[i]) end}
    When(:subject) { adapter.relay(drawn_game[8]) }
    Then { { message: "The game is a draw.",
             command: false } == subject }
  end

#  context 'when format is passed a win message' do
#    Given(:won_game) { [ "5", "2", "1", "9", "7", "4", "3" ] }
#    Given(:board) { Board.new}
#    Given(:game_runner) { GameRunner.new(board, Rules.new(board))}
#    Given(:adapter) { Adapter.new(game_runner) }
#    Given { (0..5).each do |i| adapter.relay(won_game[i]) end}
#    When(:subject) { adapter.relay(won_game[6]) }
#    Then { { message: "X wins the game!",
#             command: false } == subject }
#  end
#
#  context 'when format is passed a different win message' do
#    Given(:won_game) { [ "2", "5", "8", "1", "9", "7", "3", "4" ] }
#    Given(:board) { Board.new}
#    Given(:game_runner) { GameRunner.new(board, Rules.new(board))}
#    Given(:adapter) { Adapter.new(game_runner) }
#    Given { (0..6).each do |i| adapter.relay(won_game[i]) end}
#    When(:subject) { adapter.relay(won_game[7]) }
#    Then { { message: "O wins the game!",
#             command: false } == subject }
#  end
end
