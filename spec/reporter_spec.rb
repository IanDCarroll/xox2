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
    Given(:status) { { space: 2, 
                       board: board } }
    Given(:subject) { Reporter.new }
    When(:action) { subject.report(status) }
    Then { ["X", 2] == action }
  end

  context 'when reporter is informed of another change' do
    Given(:board) { [nil,nil,"X",
                     nil,"O",nil,
                     nil,nil,nil] }
    Given(:status) { { space: 4, 
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
    Given(:status) { { space: 8, 
                       board: board} }
    Given(:subject) { Reporter.new }
    When(:action) { subject.report(status) }
    Then { const.draw == action }
  end

  context 'when reporter encounters a win in row 1' do
    Given(:const) { GameConstants.new }
    Given(:board) { ["X","X","X",
                     "O",nil,nil,
                     nil,"O",nil] }
    Given(:status) { { space: 2,
                       board: board} }
    Given(:subject) { Reporter.new }
    When(:action) { subject.report(status) }
    Then { const.winner(status[:board][status[:space]]) == action }
  end

  context 'when reporter encounters a win in row 2' do
    Given(:const) { GameConstants.new }
    Given(:board) { [nil,"O",nil,
                     "X","X","X",
                     nil,"O",nil] }
    Given(:status) { { space: 4, 
                       board: board} }
    Given(:subject) { Reporter.new }
    When(:action) { subject.report(status) }
    Then { const.winner(status[:board][status[:space]]) == action }
  end

  context 'when reporter encounters a different player win' do
    Given(:const) { GameConstants.new }
    Given(:board) { [nil,"X","X",
                     "O","O","O",
                     nil,"X",nil] }
    Given(:status) { { space: 4, 
                       board: board} }
    Given(:subject) { Reporter.new }
    When(:action) { subject.report(status) }
    Then { const.winner(status[:board][status[:space]]) == action }
  end

  context 'when reporter encounters a win in row 3' do
    Given(:const) { GameConstants.new }
    Given(:board) { ["O","O",nil,
                     nil,nil,nil,
                     "X","X","X"] }
    Given(:status) { { space: 8, 
                       board: board} }
    Given(:subject) { Reporter.new }
    When(:action) { subject.report(status) }
    Then { const.winner(status[:board][status[:space]]) == action }
  end

  context 'when reporter encounters a win in column 1' do
    Given(:const) { GameConstants.new }
    Given(:board) { ["X",nil,nil,
                     "X",nil,nil,
                     "X","O","O"] }
    Given(:status) { { space: 6, 
                       board: board} }
    Given(:subject) { Reporter.new }
    When(:action) { subject.report(status) }
    Then { const.winner(status[:board][status[:space]]) == action }
  end

  context 'when reporter encounters a win in column 2' do
    Given(:const) { GameConstants.new }
    Given(:board) { [nil,"X",nil,
                     "O","X","O",
                     nil,"X",nil] }
    Given(:status) { { space: 4, 
                       board: board} }
    Given(:subject) { Reporter.new }
    When(:action) { subject.report(status) }
    Then { const.winner(status[:board][status[:space]]) == action }
  end

  context 'when reporter encounters a win in column 3' do
    Given(:const) { GameConstants.new }
    Given(:board) { [nil,"O","X",
                     nil,nil,"X",
                     "O",nil,"X"] }
    Given(:status) { { space: 8, 
                       board: board} }
    Given(:subject) { Reporter.new }
    When(:action) { subject.report(status) }
    Then { const.winner(status[:board][status[:space]]) == action }
  end

  context 'when reporter encounters a win in dexter diagonal' do
    Given(:const) { GameConstants.new }
    Given(:board) { ["X","O","X",
                     nil,"X","O",
                     "O",nil,"X"] }
    Given(:status) { { player: "X", space: 8, 
                       board: board} }
    Given(:subject) { Reporter.new }
    When(:action) { subject.report(status) }
    Then { const.winner(status[:board][status[:space]]) == action }
  end

  context 'when reporter encounters a win in sinister diagonal' do
    Given(:const) { GameConstants.new }
    Given(:board) { ["X","O","X",
                     "O","X",nil,
                     "X",nil,"O"] }
    Given(:status) { { space: 2, 
                       board: board} }
    Given(:subject) { Reporter.new }
    When(:action) { subject.report(status) }
    Then { const.winner(status[:board][status[:space]]) == action }
  end

  context 'when reporter encounters a win on a full board' do
    Given(:const) { GameConstants.new }
    Given(:board) { ["X","O","X",
                     "O","X","X",
                     "X","O","O"] }
    Given(:status) { { space: 2, 
                       board: board} }
    Given(:subject) { Reporter.new }
    When(:action) { subject.report(status) }
    Then { const.winner(status[:board][status[:space]]) == action }
  end
end
