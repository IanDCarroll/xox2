require 'spec_helper'
require 'rspec-given'
require 'ai/minimax'
require 'board'
require 'game_constants'


describe 'Minimax board' do
  context 'when a new board is passed to Minimax' do
    Given(:board) { Board.new }
    When(:minimax) { Minimax.new(board) }
    Then { Array.new(9) == minimax.spaces }
  end

  context 'when a new board passed to Minimax is updated' do
    Given(:board) { Board.new }
    When(:minimax) { Minimax.new(board) }
    When { board.mark(4,"X")}
    Then { [nil,nil,nil,
            nil,"X",nil,
            nil,nil,nil] == minimax.spaces }
  end
end

describe 'Minimax appropriate_player' do
  context 'when the board is new' do
    Given(:const) { GameConstants.new }
    Given(:minimax) { Minimax.new(Board.new) }
    Then { const.players[0] == minimax.appropriate_player }
  end

  context 'when the board has one mark' do
    Given(:const) { GameConstants.new }
    Given(:board) { Board.new }
    Given(:minimax) { Minimax.new(board) }
    When { board.mark(0, "X") }
    Then { const.players[1] == minimax.appropriate_player }
  end

  context 'when the board has two marks' do
    Given(:const) { GameConstants.new }
    Given(:board) { Board.new }
    Given(:minimax) { Minimax.new(board) }
    When { board.mark(0, "X") 
           board.mark(1, "O") }
    Then { const.players[0] == minimax.appropriate_player }
  end

  context 'when the board has three marks' do
    Given(:const) { GameConstants.new }
    Given(:board) { Board.new }
    Given(:minimax) { Minimax.new(board) }
    When { board.mark(0, "X") 
           board.mark(1, "O")
           board.mark(2, "X") }
    Then { const.players[1] == minimax.appropriate_player }
  end

  context 'when the board has four marks' do
    Given(:const) { GameConstants.new }
    Given(:board) { Board.new }
    Given(:minimax) { Minimax.new(board) }
    When { board.mark(0, "X") 
           board.mark(1, "O")
           board.mark(2, "X")
           board.mark(3, "O") }
    Then { const.players[0] == minimax.appropriate_player }
  end

  context 'when the board has five marks' do
    Given(:const) { GameConstants.new }
    Given(:board) { Board.new }
    Given(:minimax) { Minimax.new(board) }
    When { board.mark(0, "X") 
           board.mark(1, "O")
           board.mark(2, "X")
           board.mark(3, "O")
           board.mark(4, "X") }
    Then { const.players[1] == minimax.appropriate_player }
  end

  context 'when the board has six marks' do
    Given(:const) { GameConstants.new }
    Given(:board) { Board.new }
    Given(:minimax) { Minimax.new(board) }
    When { board.mark(0, "X") 
           board.mark(1, "O")
           board.mark(2, "X")
           board.mark(3, "O")
           board.mark(4, "X")
           board.mark(5, "O") }
    Then { const.players[0] == minimax.appropriate_player }
  end

  context 'when the board has seven marks' do
    Given(:const) { GameConstants.new }
    Given(:board) { Board.new }
    Given(:minimax) { Minimax.new(board) }
    When { board.mark(0, "X") 
           board.mark(1, "O")
           board.mark(2, "X")
           board.mark(3, "O")
           board.mark(4, "X")
           board.mark(5, "O")
           board.mark(6, "X") }
    Then { const.players[1] == minimax.appropriate_player }
  end

  context 'when the board has eight marks' do
    Given(:const) { GameConstants.new }
    Given(:board) { Board.new }
    Given(:minimax) { Minimax.new(board) }
    When { board.mark(0, "X") 
           board.mark(1, "O")
           board.mark(2, "X")
           board.mark(3, "O")
           board.mark(4, "X")
           board.mark(5, "O")
           board.mark(6, "X")
           board.mark(7, "O") }
    Then { const.players[0] == minimax.appropriate_player }
  end

  context 'when the board has nine marks' do
    Given(:const) { GameConstants.new }
    Given(:board) { Board.new }
    Given(:minimax) { Minimax.new(board) }
    When { board.mark(0, "X") 
           board.mark(1, "O")
           board.mark(2, "X")
           board.mark(3, "O")
           board.mark(4, "X")
           board.mark(5, "O")
           board.mark(6, "X")
           board.mark(7, "O")
           board.mark(8, "X") }
    Then { const.players[1] == minimax.appropriate_player }
  end
end

describe 'Minimax optimal_score' do
  context 'when there is one win one loss and depth is at min 1' do
    Given(:minimax) { Minimax.new(Board.new) }
    Given(:choices) { {5=>1, 8=>-1} }
    Given(:depth) { 1 }
    Then { -1 == minimax.optimal_score(choices, depth) }
  end

  context 'when there is one draw one win and depth is at min 1' do
    Given(:minimax) { Minimax.new(Board.new) }
    Given(:choices) { {5=>0, 8=>1} }
    Given(:depth) { 1 }
    Then { 0 == minimax.optimal_score(choices, depth) }
  end

  context 'when there is one draw one loss and depth is at min 1' do
    Given(:minimax) { Minimax.new(Board.new) }
    Given(:choices) { {5=>0, 8=>-1} }
    Given(:depth) { 1 }
    Then { -1 == minimax.optimal_score(choices, depth) }

  end
  context 'when there is one win one loss and depth is at max 2' do
    Given(:minimax) { Minimax.new(Board.new) }
    Given(:choices) { {5=>1, 8=>-1} }
    Given(:depth) { 2 }
    Then { 1 == minimax.optimal_score(choices, depth) }

  end
  context 'when there is one win one draw and depth is at max 2' do
    Given(:minimax) { Minimax.new(Board.new) }
    Given(:choices) { {5=>0, 8=>1} }
    Given(:depth) { 2 }
    Then { 1 == minimax.optimal_score(choices, depth) }

  end
  context 'when there is one draw one loss and depth is at max 2' do
    Given(:minimax) { Minimax.new(Board.new) }
    Given(:choices) { {5=>0, 8=>-1} }
    Given(:depth) { 2 }
    Then { 0 == minimax.optimal_score(choices, depth) }
  end
end

describe "Minimax optimum_choice" do
  context 'when the board is drawn' do
    Given(:board) { Board.new }
    Given(:minimax) { Minimax.new(board) }
    When { board.mark(8, "X")
           board.mark(0, "O")
           board.mark(1, "X")
           board.mark(2, "O")
           board.mark(4, "X")
           board.mark(3, "O")
           board.mark(5, "X")
           board.mark(7, "O")
           board.mark(6, "X") } 
    Then { 0 == minimax.optimum_choice }
  end

  context 'when the board is lost at the last move' do
    Given(:board) { Board.new }
    Given(:minimax) { Minimax.new(board) }
    When { board.mark(1, "X")
           board.mark(4, "O")
           board.mark(2, "X")
           board.mark(5, "O")
           board.mark(3, "X")
           board.mark(7, "O")
           board.mark(6, "X")
           board.mark(8, "O")
           board.mark(0, "X") } 
    Then { -1 == minimax.optimum_choice }
  end

  context 'when the board is lost early' do
    Given(:board) { Board.new }
    Given(:minimax) { Minimax.new(board) }
    When { board.mark(0, "X")
           board.mark(8, "O")
           board.mark(1, "X")
           board.mark(7, "O")
           board.mark(2, "X") } 
    Then { -1 == minimax.optimum_choice }
  end

   context 'when the board is won early' do
    Given(:board) { Board.new }
    Given(:minimax) { Minimax.new(board) }
    When { board.mark(0, "X")
           board.mark(8, "O")
           board.mark(1, "X")
           board.mark(7, "O")
           board.mark(4, "X") 
           board.mark(6, "O") }
    Then { 1 == minimax.optimum_choice }
  end 

  context 'when there are two moves left and one wins' do
    Given(:board) { Board.new }
    Given(:minimax) { Minimax.new(board) }
    When { board.mark(8, "X")
           board.mark(0, "O")
           board.mark(1, "X")
           board.mark(2, "O")
           board.mark(4, "X")
           board.mark(3, "O")
           board.mark(5, "X") }
    Then { 6 == minimax.optimum_choice }
    And  { {6=>1, 7=>0} == minimax.choices }
  end

   context 'when there are two moves left and one loses' do
    Given(:board) { Board.new }
    Given(:minimax) { Minimax.new(board) }
    When { board.mark(1, "X")
           board.mark(2, "O")
           board.mark(4, "X")
           board.mark(7, "O")
           board.mark(5, "X")
           board.mark(8, "O")
           board.mark(6, "X") }
    Then { 3 == minimax.optimum_choice }
    And  { {0=>-1, 3=>0} == minimax.choices }
  end

   context 'when there are two moves left and both draw' do
    Given(:board) { Board.new }
    Given(:minimax) { Minimax.new(board) }
    When { board.mark(1, "X")
           board.mark(0, "O")
           board.mark(3, "X")
           board.mark(4, "O")
           board.mark(6, "X")
           board.mark(7, "O")
           board.mark(8, "X") }
    Then { 2 == minimax.optimum_choice }
    And  { {2=>0, 5=>0} == minimax.choices }
  end

  context 'when there are two moves left, one win, one loss' do
    Given(:board) { Board.new }
    Given(:minimax) { Minimax.new(board) }
    When { board.mark(0, "X")
           board.mark(4, "O")
           board.mark(1, "X")
           board.mark(7, "O")
           board.mark(3, "X")
           board.mark(8, "O")
           board.mark(5, "X") }
    Then { 6 == minimax.optimum_choice }
    And  { {2=>-1, 6=>1} == minimax.choices }
  end 

  context 'when there is an early chance to win or fork on rows' do
    Given(:board) { Board.new }
    Given(:minimax) { Minimax.new(board) }
    When { board.mark(8, "X")
           board.mark(0, "O")
           board.mark(7, "X")
           board.mark(1, "O")
           board.mark(4, "X") }
    Then { 2 == minimax.optimum_choice }
    And  { {2=>1, 3=>-1, 5=>-1, 6=>1} == minimax.choices }
  end

  context 'when there is an early chance to win or fork on rows' do
    Given(:board) { Board.new }
    Given(:minimax) { Minimax.new(board) }
    When { board.mark(8, "X")
           board.mark(0, "O")
           board.mark(4, "X")
           board.mark(2, "O")
           board.mark(6, "X") }
    Then { 1 == minimax.optimum_choice }
    And  { {1=>1, 3=>-1, 5=>-1, 7=>0} == minimax.choices }
  end 

  context 'when there is an early chance to loose and win on rows' do
    Given(:board) { Board.new }
    Given(:minimax) { Minimax.new(board) }
    When { board.mark(0, "X")
           board.mark(6, "O")
           board.mark(4, "X")
           board.mark(8, "O")
           board.mark(2, "X") }
    Then { 7 == minimax.optimum_choice }
    And  { {1=>0, 3=>-1, 5=>-1, 7=>1} == minimax.choices }
  end

  context 'when there is an early chance to loose and win on cols' do
    Given(:board) { Board.new }
    Given(:minimax) { Minimax.new(board) }
    When { board.mark(0, "X")
           board.mark(2, "O")
           board.mark(4, "X")
           board.mark(8, "O")
           board.mark(6, "X") }
    Then { 5 == minimax.optimum_choice }
    And  { {1=>-1, 3=>0, 5=>1, 7=>-1} == minimax.choices }
  end

  context 'when there is an early chance to win against a fork on cols' do
    Given(:board) { Board.new }
    Given(:minimax) { Minimax.new(board) }
    When { board.mark(8, "X")
           board.mark(3, "O")
           board.mark(5, "X")
           board.mark(6, "O")
           board.mark(4, "X") }
    Then { 0 == minimax.optimum_choice }
    And  { {0=>1, 1=>-1, 2=>-1, 7=>-1} == minimax.choices }
  end

  context 'when there is an early chance to lose and fork-win on space 2' do
    Given(:board) { Board.new }
    Given(:minimax) { Minimax.new(board) }
    When { board.mark(0, "X") 
           board.mark(8, "O") 
           board.mark(1, "X") }
    Then { 2 == minimax.optimum_choice }
    And { {2=>1, 3=>-1, 4=>-1, 5=>-1, 6=>-1, 7=>-1} == minimax.choices }
  end

  context 'when there is an early chance to lose on space 8' do
    Given(:board) { Board.new }
    Given(:minimax) { Minimax.new(board) }
    When { board.mark(0, "X") 
           board.mark(2, "O") 
           board.mark(4, "X") }
    Then { 8 == minimax.optimum_choice }
    And { {1=>-1, 3=>-1, 5=>-1, 6=>-1, 7=>-1, 8=>0} == minimax.choices }
  end

  context 'when it chooses to distract against an L-fork' do
    Given(:board) { Board.new }
    Given(:minimax) { Minimax.new(board) }
    When { board.mark(2, "X") 
           board.mark(0, "O") 
           board.mark(4, "X") }
    Then { 6 == minimax.optimum_choice }
    And { {1=>-1, 3=>-1, 5=>-1, 6=>0, 7=>-1, 8=>-1} == minimax.choices }
  end

  context 'when it chooses to distract against a triangle fork' do
    Given(:board) { Board.new }
    Given(:minimax) { Minimax.new(board) }
    When { board.mark(4, "X") 
           board.mark(0, "O") 
           board.mark(8, "X") }
    Then { 2 == minimax.optimum_choice }
    And { {1=>-1, 2=>0, 3=>-1, 5=>-1, 6=>0, 7=>-1} == minimax.choices }
  end

  context 'when an arrowhead fork has occured' do
    Given(:board) { Board.new }
    Given(:minimax) { Minimax.new(board) }
    When { board.mark(5, "X") 
           board.mark(4, "O") 
           board.mark(7, "X")
           board.mark(0, "O")
           board.mark(8, "X") }
    Then { 1 == minimax.optimum_choice }
    And { {1=>-1, 2=>-1, 3=>-1, 6=>-1} == minimax.choices }
  end

  context 'when it chooses to block against an arrowhead fork' do
    Given(:board) { Board.new }
    Given(:minimax) { Minimax.new(board) }
    When { board.mark(5, "X") 
           board.mark(4, "O") 
           board.mark(7, "X") }
    Then { 2 == minimax.optimum_choice }
    And { {0=>-1, 1=>-1, 2=>0, 3=>-1, 6=>0, 8=>0} == minimax.choices }
  end
end
