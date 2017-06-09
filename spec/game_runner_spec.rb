require 'rspec/given'
require 'game_runner'
require 'board'
require 'rules'

describe 'GameRunner init' do
  context 'when GameRunner starts up' do
    Given(:board) { Board.new }
    Given(:rules) { Rules.new(board) }
    Given(:subject) { GameRunner.new(board, rules) }
    Then { raise_error != subject }
  end
end

describe 'GameRunner play' do
  context 'when play is called as a new game' do
    Given(:board) { Board.new }
    Given(:rules) { Rules.new(board) }
    Given(:game_runner) { GameRunner.new(board, rules) }
    When(:subject) { game_runner.play('start') }
    Then { { continue_game?: true,
             play_again?: true,
             user_message: [ "new", "game"], 
             board: board.spaces } == subject }
  end

  context 'when play is called on the first move' do
    Given(:board) { Board.new }
    Given(:rules) { Rules.new(board) }
    Given(:game_runner) { GameRunner.new(board, rules) }
    When(:subject) { game_runner.play(4) }
    Then { { continue_game?: true,
             play_again?: true,
             user_message: [ "X", 4 ], 
             board: [ "1", "2", "3",
                      "4", "X", "6",
                      "7", "8", "9" ] } == subject }
  end

  context 'when play is called on the second move' do
    Given(:board) { Board.new }
    Given(:rules) { Rules.new(board) }
    Given(:game_runner) { GameRunner.new(board, rules) }
    When(:subject) { game_runner.play(4)
                     game_runner.play(0) }
    Then { { continue_game?: true,
             play_again?: true,
             user_message: [ "O", 0 ], 
             board: [ "O", "2", "3",
                      "4", "X", "6",
                      "7", "8", "9" ] } == subject }
  end

  context 'when play is called to reset the game' do
    Given(:board) { Board.new }
    Given(:rules) { Rules.new(board) }
    Given(:game_runner) { GameRunner.new(board, rules) }
    When { 7.times do |i| game_runner.play(i) end }
    When(:subject) { game_runner.play('start') }
    Then { { continue_game?: true,
             play_again?: true, 
             user_message: [ "new", "game" ], 
             board: [ "1", "2", "3",
                      "4", "5", "6",
                      "7", "8", "9" ] } == subject }
  end

  context 'when play is called to exit the game' do
    Given(:board) { Board.new }
    Given(:rules) { Rules.new(board) }
    Given(:game_runner) { GameRunner.new(board, rules) }
    When { 5.times do |i| game_runner.play(i) end }
    When(:subject) { game_runner.play('exit') }
    Then { { continue_game?: false,
             play_again?: false,
             user_message: [ "end", "game" ], 
             board: [ "X", "O", "X",
                      "O", "X", "6",
                      "7", "8", "9" ] } == subject }
  end

  context 'when play is called and the game is drawn' do
    Given(:drawn_game) { [ 4, 0, 8, 6, 3, 5, 7, 1, 2 ] }
    Given(:board) { Board.new }
    Given(:rules) { Rules.new(board) }
    Given(:game_runner) { GameRunner.new(board, rules) }
    When { (0..7).each do |i| game_runner.play(drawn_game[i]) end }
    When(:subject) { game_runner.play(drawn_game[8]) }
    Then { { continue_game?: false,
             play_again?: true,
             user_message: [ "game", "draw" ], 
             board: [ "O", "O", "X",
                      "X", "X", "O",
                      "O", "X", "X" ] } == subject }
  end
end
