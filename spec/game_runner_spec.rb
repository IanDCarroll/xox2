require 'spec_helper'
require 'rspec/given'
require 'game_runner'
require 'board'
require 'rules'
require 'cli/adapter'
require 'mock_shell'

describe 'GameRunner init' do
  context 'when GameRunner starts up' do
    Given(:board) { Board.new }
    Given(:rules) { Rules.new(board) }
    Given(:adapter) { Adapter.new }
    Given(:subject) { GameRunner.new(board, rules, adapter) }
    Then { raise_error != subject }
  end
end

describe 'GameRunner play' do
  context 'when play is called as a new game' do
    Given(:const) { GameConstants.new }
    Given(:board) { Board.new }
    Given(:rules) { Rules.new(board) }
    Given(:adapter) { Adapter.new }
    Given(:game_runner) { GameRunner.new(board, rules, adapter) }
    When(:subject) { game_runner.play('start') }
    Then { { message: const.new_game, 
             board: board.spaces } == subject }
  end

  context 'when play is called on the first move' do
    Given(:board) { Board.new }
    Given(:rules) { Rules.new(board) }
    Given(:adapter) { Adapter.new }
    Given(:game_runner) { GameRunner.new(board, rules, adapter)}
    When(:subject) { game_runner.play(4) }
    Then { { message: [ "X", 4 ], 
             board: [ nil, nil, nil,
                      nil, "X", nil,
                      nil, nil, nil ] } == subject }
  end

  context 'when play is called on the second move' do
    Given(:board) { Board.new }
    Given(:rules) { Rules.new(board) }
    Given(:adapter) { Adapter.new }
    Given(:game_runner) { GameRunner.new(board, rules, adapter)}
    When(:subject) { game_runner.play(4)
                     game_runner.play(0) }
    Then { { message: [ "O", 0 ], 
             board: [ "O", nil, nil,
                      nil, "X", nil,
                      nil, nil, nil ] } == subject }
  end

  context 'when play is called to reset the game' do
    Given(:const) { GameConstants.new }
    Given(:board) { Board.new }
    Given(:rules) { Rules.new(board) }
    Given(:adapter) { Adapter.new }
    Given(:game_runner) { GameRunner.new(board, rules, adapter)}
    When { 7.times do |i| game_runner.play(i) end }
    When(:subject) { game_runner.play('start') }
    Then { { message: const.new_game, 
             board: [ nil, nil, nil,
                      nil, nil, nil,
                      nil, nil, nil ] } == subject }
  end

  context 'when play is called to exit the game' do
    Given(:const) { GameConstants.new }
    Given(:board) { Board.new }
    Given(:rules) { Rules.new(board) }
    Given(:adapter) { Adapter.new }
    Given(:game_runner) { GameRunner.new(board, rules, adapter)}
    When { 5.times do |i| game_runner.play(i) end }
    When(:subject) { game_runner.play('exit') }
    Then { { message: const.end_game, 
             board: [ "X", "O", "X",
                      "O", "X", nil,
                      nil, nil, nil ] } == subject }
  end

  context 'when play is called and the game is drawn' do
    Given(:drawn_game) { [ 4, 0, 8, 6, 3, 5, 7, 1, 2 ] }
    Given(:const) { GameConstants.new }
    Given(:board) { Board.new }
    Given(:rules) { Rules.new(board) }
    Given(:adapter) { Adapter.new }
    Given(:game_runner) { GameRunner.new(board, rules, adapter)}
    When { (0..7).each do |i| game_runner.play(drawn_game[i]) end }
    When(:subject) { game_runner.play(drawn_game[8]) }
    Then { { message: const.draw, 
             board: [ "O", "O", "X",
                      "X", "X", "O",
                      "O", "X", "X" ] } == subject }
  end

  context 'when an error is reported to play' do
    Given(:const) { GameConstants.new }
    Given(:board) { Board.new }
    Given(:rules) { Rules.new(board) }
    Given(:adapter) { Adapter.new }
    Given(:game_runner) { GameRunner.new(board, rules, adapter)}
    When(:subject) { game_runner.play('error') }
    Then { { message: const.bad_move, 
             board: [ nil, nil, nil,
                      nil, nil, nil,
                      nil, nil, nil ] } == subject }
  end
end

describe 'GameRunner play_again' do
  context 'when play-again is called' do
    Given(:const) { GameConstants.new }
    Given(:board) { Board.new }
    Given(:rules) { Rules.new(board) }
    Given(:adapter) { Adapter.new }
    Given(:game_runner) { GameRunner.new(board, rules, adapter)}
    When(:subject) { game_runner.play_again }
    Then { { message: const.play_again, 
           board: [ nil, nil, nil,
                    nil, nil, nil,
                    nil, nil, nil ] } == subject }
  end
end

describe 'GameRunner reset_game?' do
  context 'when reset_game? is called to reset the game' do
    Given(:board) { Board.new }
    Given(:rules) { Rules.new(board) }
    Given(:adapter) { Adapter.new(MockShell.new) }
    Given(:game_runner) { GameRunner.new(board, rules, adapter) }
    When(:reset) { game_runner.reset_game?("start") }
    Then { nil == reset }
  end
end

describe 'GameRunner play_again?' do
  context 'when play_again? is called after exit_command' do
    Given(:board) { Board.new }
    Given(:rules) { Rules.new(board) }
    Given(:adapter) { Adapter.new(MockShell.new) }
    Given(:game_runner) { GameRunner.new(board, rules, adapter) }
    When(:play_again) { game_runner.exit_command
                        game_runner.play_again? }
    Then { nil == play_again }
  end

  context 'when play_again? is called and player does not answer "start"' do
    Given(:board) { Board.new }
    Given(:rules) { Rules.new(board) }
    Given(:adapter) { Adapter.new(MockShell.new) }
    Given(:game_runner) { GameRunner.new(board, rules, adapter) }
    When(:play_again) { game_runner.play_again? }
    Then { nil == play_again }
  end
end

describe 'GameRunner start_game' do
  context 'when start_game is called' do
    Given(:board) { Board.new }
    Given(:rules) { Rules.new(board) }
    Given(:adapter) { Adapter.new(MockShell.new) }
    Given(:game_runner) { GameRunner.new(board, rules, adapter) }
    When(:start_game) { game_runner.start_game }
    Then { nil == start_game }
  end
end

describe 'GameRunner make_a_move' do
  context 'when the AI goes second' do
    Given(:board) { Board.new }
    Given(:adapter) { Adapter.new(MockShell.new) }
    Given(:ai) { ComputerPlayer.new }
    Given(:game_runner) { GameRunner.new(board, Rules.new(board), adapter) }
    When(:make_a_move) { ai.push_status(game_runner.new_game)
                         game_runner.play(ai.pull_move) 
                         game_runner.make_a_move }
    Then{ { message: ["O", 1], 
            board: ["X", "O", nil, 
                    nil, nil, nil, 
                    nil, nil, nil] } == make_a_move } 
  end
end
