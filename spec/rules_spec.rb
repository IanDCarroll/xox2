require 'spec_helper'
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
    Given(:rules) { Rules.new(board) }
    When(:subject) { rules.mark(4) }
    Then { [ "1","2","3",
             "4","X","6",
             "7","8","9" ] == board.spaces }
    And { ["X", 4] == subject } 
  end

  context 'when the second player marks the board' do
    Given(:board) { Board.new }
    Given(:rules) { Rules.new(board) }
    Given { rules.mark(4) }
    When(:subject) { rules.mark(0) }
    Then { [ "O","2","3",
             "4","X","6",
             "7","8","9" ] == board.spaces }
    And { ["O", 0] == subject }
  end
end

describe "Rules reset" do
  context "when a played game is reset" do
    Given(:reset_game) { { player: "O",
                           space: "any value",
                           board: [ "1", "2", "3",
                                    "4", "5", "6",
                                    "7", "8", "9" ] } }
    Given(:game_moves) { [ "5", "2", "1", "9", "7", "4", "3" ] }
    Given(:board) { Board.new }
    Given(:rules) { Rules.new(board) }
    When { (0...game_moves.length).each do |i| rules.mark(i) end }
    When(:subject) { rules.reset }
    Then { reset_game == rules.status("any value") }
  end
end
