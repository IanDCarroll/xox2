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
    Then { [ nil,nil,nil,
             nil,"X",nil,
             nil,nil,nil ] == board.spaces }
    And { ["X", 4] == subject } 
  end

  context 'when the second player marks the board' do
    Given(:board) { Board.new }
    Given(:rules) { Rules.new(board) }
    Given { rules.mark(4) }
    When(:subject) { rules.mark(0) }
    Then { [ "O",nil,nil,
             nil,"X",nil,
             nil,nil,nil ] == board.spaces }
    And { ["O", 0] == subject }
  end
end

describe "Rules reset" do
  context "when a played game is reset" do
    Given(:reset_game) { { space: "any value",
                           board: [ nil, nil, nil,
                                    nil, nil, nil,
                                    nil, nil, nil ] } }
    Given(:game_moves) { [ "5", "2", "1", "9", "7", "4", "3" ] }
    Given(:board) { Board.new }
    Given(:rules) { Rules.new(board) }
    When { (0...game_moves.length).each do |i| rules.mark(i) end }
    When(:subject) { rules.reset }
    Then { reset_game == rules.status("any value") }
  end
end
