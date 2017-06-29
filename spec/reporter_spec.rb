require 'spec_helper'
require 'rspec/given'
require 'reporter'
require 'game_constants'

describe 'Reporter init' do
  context 'when reporter initializes' do
    Given(:action) { Reporter.new }
    Then { raise_error != action }
  end
end

describe 'Reporter report' do
  context 'when reporter is informed of a change' do
    Given(:board) { [nil,nil,"X",
                     nil,nil,nil,
                     nil,nil,nil] }
    Given(:status) { { player: "X", space: 2, moves: 1, size: 9, 
                       board: board } }
    Given(:subject) { Reporter.new }
    When(:action) { subject.report(status) }
    Then { ["X", 2] == action }
  end

  context 'when reporter is informed of another change' do
    Given(:board) { [nil,nil,"X",
                     nil,"O",nil,
                     nil,nil,nil] }
    Given(:status) { { player: "O", space: 4, moves: 2, size: 9, 
                      board: board} }
    When(:action) { subject.report(status) }
    Given(:subject) { Reporter.new }
    Then { ["O", 4] == action }
  end

  context 'when reporter encounters a full board' do
    Given(:const) { GameConstants.new }
    Given(:board) { ["O","X","O",
                     "X","X","O",
                     "X","O","X"] }
    Given(:status) { { player: "X", space: 8, moves: 9, size: 9, 
                       board: board} }
    Given(:subject) { Reporter.new }
    When(:action) { subject.report(status) }
    Then { const.draw == action }
  end

  context 'when reporter encounters a win in row 1' do
    Given(:board) { ["X","X","X",
                     "O",nil,nil,
                     nil,"O",nil] }
    Given(:status) { { player: "X", space: 8, moves: 5, size: 9, 
                       board: board} }
    Given(:subject) { Reporter.new }
    When(:action) { subject.report(status) }
    Then { ["X", "win" ] == action }
  end

  context 'when reporter encounters a win in row 2' do
    Given(:board) { [nil,"O",nil,
                     "X","X","X",
                     nil,"O",nil] }
    Given(:status) { { player: "X", space: 8, moves: 5, size: 9, 
                       board: board} }
    Given(:subject) { Reporter.new }
    When(:action) { subject.report(status) }
    Then { ["X", "win" ] == action }
  end

  context 'when reporter encounters a different player win' do
    Given(:board) { [nil,"X","X",
                     "O","O","O",
                     nil,"X",nil] }
    Given(:status) { { player: "O", space: 8, moves: 6, size: 9, 
                       board: board} }
    Given(:subject) { Reporter.new }
    When(:action) { subject.report(status) }
    Then { ["O", "win" ] == action }
  end

  context 'when reporter encounters a win in row 3' do
    Given(:board) { ["O","O",nil,
                     nil,nil,nil,
                     "X","X","X"] }
    Given(:status) { { player: "X", space: 8, moves: 5, size: 9, 
                       board: board} }
    Given(:subject) { Reporter.new }
    When(:action) { subject.report(status) }
    Then { ["X", "win" ] == action }
  end

  context 'when reporter encounters a win in column 1' do
    Given(:board) { ["X",nil,nil,
                     "X",nil,nil,
                     "X","O","O"] }
    Given(:status) { { player: "X", space: 8, moves: 5, size: 9, 
                       board: board} }
    Given(:subject) { Reporter.new }
    When(:action) { subject.report(status) }
    Then { ["X", "win" ] == action }
  end

  context 'when reporter encounters a win in column 2' do
    Given(:board) { [nil,"X",nil,
                     "O","X","O",
                     nil,"X",nil] }
    Given(:status) { { player: "X", space: 8, moves: 5, size: 9, 
                       board: board} }
    Given(:subject) { Reporter.new }
    When(:action) { subject.report(status) }
    Then { ["X", "win" ] == action }
  end

  context 'when reporter encounters a win in column 3' do
    Given(:board) { [nil,"O","X",
                     nil,nil,"X",
                     "O",nil,"X"] }
    Given(:status) { { player: "X", space: 8, moves: 5, size: 9, 
                       board: board} }
    Given(:subject) { Reporter.new }
    When(:action) { subject.report(status) }
    Then { ["X", "win" ] == action }
  end

  context 'when reporter encounters a win in dexter diagonal' do
    Given(:board) { ["X","O","X",
                     nil,"X","O",
                     "O",nil,"X"] }
    Given(:status) { { player: "X", space: 8, moves: 7, size: 9, 
                       board: board} }
    Given(:subject) { Reporter.new }
    When(:action) { subject.report(status) }
    Then { ["X", "win" ] == action }
  end

  context 'when reporter encounters a win in sinister diagonal' do
    Given(:board) { ["X","O","X",
                     "O","X",nil,
                     "X",nil,"O"] }
    Given(:status) { { player: "X", space: 8, moves: 7, size: 9, 
                       board: board} }
    Given(:subject) { Reporter.new }
    When(:action) { subject.report(status) }
    Then { ["X", "win" ] == action }
  end

  context 'when reporter encounters a win on a full board' do
    Given(:board) { ["X","O","X",
                     "O","X","X",
                     "X","O","O"] }
    Given(:status) { { player: "X", space: 8, moves: 9, size: 9, 
                       board: board} }
    Given(:subject) { Reporter.new }
    When(:action) { subject.report(status) }
    Then { ["X", "win" ] == action }
  end
end
