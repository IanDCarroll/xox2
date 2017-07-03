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

describe 'Minimax available_spaces' do
  context 'when minimax needs a list of optional moves' do
    Given(:minimax) { Minimax.new(Board.new) }
    Then { [0,1,2,3,4,5,6,7,8] == minimax.available_spaces }
  end

  context 'when the list of available spaces is from a used board' do
    Given(:board) { Board.new }
    Given(:minimax) { Minimax.new(board) }
    When { board.mark(0, "X")
           board.mark(2, "X")
           board.mark(4, "X")
           board.mark(6, "O")
           board.mark(8, "O") }
    Then { [1,3,5,7] == minimax.available_spaces }
  end

   context 'when the list takes integers as not available from a used board' do
    Given(:board) { Board.new }
    Given(:minimax) { Minimax.new(board) }
    When { board.mark(0, 1)
           board.mark(2, 1)
           board.mark(4, 1)
           board.mark(6, 1)
           board.mark(8, 1) }
    Then { [1,3,5,7] == minimax.available_spaces }
  end
end

describe 'Minimax make_ultimate_choice' do
  context 'when passed a scored board with a loss and a win' do
    Given { @count = 0 }
    Given(:minimax) { Minimax.new(Board.new) }
    Given(:scored_spaces) { [ "O", "X", -1 ,
                              "O", "X", "X",
                               1 , "O", "X"] }
    Then { 6 == minimax.make_ultimate_choice(scored_spaces) }
  end

  context 'when passed a scored board with a win and a loss' do
    Given(:minimax) { Minimax.new(Board.new) }
    Given(:scored_spaces) { [  1 ,"X","X",
                              "O","X","X",
                              "O","O", -1] }
    Then { 0 == minimax.make_ultimate_choice(scored_spaces) }
  end

  context 'when passed a scored board with a loss then a draw' do
    Given(:minimax) { Minimax.new(Board.new) }
    Given(:scored_spaces) { [ -1 ,"X","X",
                              "X","O","O",
                              "X","O", 0 ] }
    Then { 8 == minimax.make_ultimate_choice(scored_spaces) }
  end

  context 'when passed a scored board with a draw then a win' do
    Given(:minimax) { Minimax.new(Board.new) }
    Given(:scored_spaces) { [ "O","X", 0,
                              "O","X","X",
                               1 ,"O","O"] }
    Then { 6 == minimax.make_ultimate_choice(scored_spaces) }
  end

  context 'when passed a scored board with a win then a draw' do
    Given(:minimax) { Minimax.new(Board.new) }
    Given(:scored_spaces) { [  1 ,"O","O",
                              "O","X","X",
                              "O","X", 0 ] }
    Then { 0 == minimax.make_ultimate_choice(scored_spaces) }
  end

  context 'when passed a scored board with two wins' do
    Given(:minimax) { Minimax.new(Board.new) }
    Given(:scored_spaces) { [ "X","X", 1 ,
                              "O","O", 1 ,
                              "O","X","X" ] }
    Then { 2 == minimax.make_ultimate_choice(scored_spaces) }
  end

  context 'when passed a scored board with two losses' do
    Given(:minimax) { Minimax.new(Board.new) }
    Given(:scored_spaces) { [ "O","O",-1 ,
                              "X","X",-1 ,
                              "X","O","O"] }
    Then { 2 == minimax.make_ultimate_choice(scored_spaces) }
  end

  context 'when passed a scored board with two draws' do
    Given(:minimax) { Minimax.new(Board.new) }
    Given(:scored_spaces) { [ "O","X","O",
                               0 ,"X", 0 ,
                              "X","O","X"] }
    Then { 3 == minimax.make_ultimate_choice(scored_spaces) }
  end

  context 'if passed a full board' do
    Given(:minimax) { Minimax.new(Board.new) }
    Given(:scored_spaces) { [ "O","X","O",
                              "O","X","X",
                              "X","O","X"] }
    Then { "no ultimate choice made" == minimax.make_ultimate_choice(scored_spaces) }
  end
end

describe 'Minimax score_spaces' do
  context "when recursion_depth returns to 0 after score speaces completes" do
    Given(:board) { Board.new }
    Given(:minimax) { Minimax.new(board) }
    When { minimax.score_spaces }
    Then { 0 == minimax.recursion_depth }
  end

  context 'when the board does not persist between enumerations' do
    Given(:board) { Board.new }
    Given(:minimax) { Minimax.new(board) }
    When { minimax.score_spaces }
    Then { minimax.spaces == board.spaces }
    And  { Board.new.spaces != minimax.spaces }
    And  { Array.new(9, 2) == board.spaces }
  end

  context 'when a board has one square that looses' do
    Given(:board) { Board.new }
    Given(:minimax) { Minimax.new(board) }
    Given{ minimax.recursion_depth += 1 }
    Given{ board.mark(1, "X") 
           board.mark(4, "O")
           board.mark(2, "X")
           board.mark(5, "O")
           board.mark(3, "X")
           board.mark(7, "O") 
           board.mark(6, "X")
           board.mark(8, "O") }
    Given(:scored_spaces) { [ -1 ,"X","X",
                              "X","O","O",
                              "X","O","O"] }
    Then { scored_spaces == minimax.score_spaces }
  end

  context 'when a board has one square that wins' do
    Given(:board) { Board.new }
    Given(:minimax) { Minimax.new(board) }
    Given{ board.mark(1, "O") 
           board.mark(4, "X")
           board.mark(2, "O")
           board.mark(5, "X")
           board.mark(3, "O")
           board.mark(7, "X") 
           board.mark(6, "O")
           board.mark(8, "X") }
    Given(:scored_spaces) { [  1 ,"O","O",
                              "O","X","X",
                              "O","X","X"] }
    Then { scored_spaces == minimax.score_spaces }
  end

  context 'when a board has one square that draws' do
    Given(:board) { Board.new }
    Given(:minimax) { Minimax.new(board) }
    Given{ minimax.recursion_depth += 1 }
    Given{ board.mark(4, "X")
           board.mark(3, "O")
           board.mark(2, "X")
           board.mark(6, "O")
           board.mark(5, "X")
           board.mark(8, "O")
           board.mark(7, "X")
           board.mark(1, "O") } 
    Given(:scored_spaces) { [  0 ,"O","X",
                              "O","X","X",
                              "O","X","O"] }
    Then { scored_spaces == minimax.score_spaces }
  end

#  context 'when a board has two squares that draw at recursion_depth 2' do
#    Given(:board) { Board.new }
#    Given(:minimax) { Minimax.new(board) }
#    Given{ board.mark(2, "X")
#           board.mark(1, "O") 
#           board.mark(3, "X")
#           board.mark(6, "O")
#           board.mark(8, "X")
#           board.mark(5, "O")
#           board.mark(7, "X") } 
#    Given(:scored_spaces) { [  0 ,"O","X",
#                              "X", 0 ,"O",
#                              "O","X","X"] }
#    Then { scored_spaces == minimax.score_spaces }
#  end

end

describe 'Minimax score_space' do
  context 'when a win codition is reported' do
    Given(:const) { GameConstants.new }
    Given(:board) { Board.new }
    Given(:minimax) { Minimax.new(board) }
    Given(:report) { const.winner("O") }
    When { minimax.recursion_depth += 1 }
    When { board.mark(3,"O") 
           board.mark(4,"O")}
    Then { 1 == minimax.score_space(5) }
  end

  context 'when a loss codition is reported' do
    Given(:const) { GameConstants.new }
    Given(:board) { Board.new }
    Given(:minimax) { Minimax.new(board) }
    Given(:report) { const.winner("X") }
    When { minimax.recursion_depth = 2 }
    When { board.mark(3,"X") 
           board.mark(4,"X") } 
    Then { -1 == minimax.score_space(5) }
  end

  context 'when a draw codition is reported' do
    Given(:const) { GameConstants.new }
    Given(:board) { Board.new }
    Given(:minimax) { Minimax.new(board) }
    Given(:report) { const.draw }
    When { minimax.recursion_depth = 2 } 
    When { board.mark(1,"X")
           board.mark(0,"O") 
           board.mark(2,"X")
           board.mark(4,"O")
           board.mark(3,"X")
           board.mark(5,"O")
           board.mark(6,"X")
           board.mark(7,"O") }
    Then { 0 == minimax.score_space(8) }
  end
end

describe 'Minimax report' do
  context 'When preparing a report does not modify the original board' do
    Given(:board) { Board.new }
    Given(:minimax) { Minimax.new(board) }
    When { minimax.recursion_depth += 1 }
    When { minimax.report(0) }
    Then { Board.new.spaces == board.spaces }  
 
  end

  context 'when a board and available space that wins are passed' do
    Given(:const) { GameConstants.new }
    Given(:board) { Board.new }
    Given(:minimax) { Minimax.new(board) }
    When { minimax.recursion_depth += 1 }
    When { board.mark(3,"O") 
           board.mark(4,"O") } 
    Then { const.winner(const.players[1]) == minimax.report(5) }
  end

  context 'when a board and available space that wins are passed' do
    Given(:const) { GameConstants.new }
    Given(:board) { Board.new }
    Given(:minimax) { Minimax.new(board) }
    When { minimax.recursion_depth = 2 }
    When { board.mark(3,"X") 
           board.mark(4,"X") } 
    Then { const.winner(const.players[0]) == minimax.report(5) }
  end

  context 'when a board is drawn with the last move' do
    Given(:const) { GameConstants.new }
    Given(:board) { Board.new }
    Given(:minimax) { Minimax.new(board) }
    When { minimax.recursion_depth = 2 }
    When { board.mark(1,"X")
           board.mark(0,"O") 
           board.mark(2,"X")
           board.mark(4,"O")
           board.mark(3,"X")
           board.mark(5,"O")
           board.mark(6,"X")
           board.mark(7,"O") }
    Then { const.draw == minimax.report(8) }
  end
end

describe 'Minimax recursion_counter' do
  context 'when recursion_counter has not been called' do
    Given(:minimax) { Minimax.new(Board.new) }
    Then { 0 == minimax.recursion_depth }
  end

  context 'when called to track a deeper recursion' do
    Given(:minimax) { Minimax.new(Board.new) }
    When { minimax.recursion_depth += 1 }
    Then { 1 == minimax.recursion_depth }
  end

  context 'when called to track a surfacing recursion' do
    Given(:minimax) { Minimax.new(Board.new) }
    When { minimax.recursion_depth += 1
           minimax.recursion_depth -= 1 }
    Then { 0 == minimax.recursion_depth }
  end
end

describe 'Minimax appropriate_player' do
  context 'when recursion_depth is at the root level' do
    Given(:const) { GameConstants.new }
    Given(:minimax) { Minimax.new(Board.new) }
    When { minimax.recursion_depth += 1 }
    Then { const.players[1] = minimax.appropriate_player }
  end

  context 'when recurstion_depth is an even number' do
    Given(:const) { GameConstants.new }
    Given(:minimax) { Minimax.new(Board.new) }
    When { minimax.recursion_depth += 1 
           minimax.recursion_depth += 1 }
    Then { const.players[0] = minimax.appropriate_player }
  end
end

#describe 'Minimax score_spaces' do
#  context 'when a board has one square that looses' do
#    Given(:minimax) { Minimax.new(Board.new) }
#    Given(:unscored_spaces) { [ nil,"X","X",
#                                "X","O","O",
#                                "X","O","O"] }
#    Given(:scored_spaces) { [ -1 ,"X","X",
#                              "X","O","O",
#                              "X","O","O"] }
#    Then { scored_spaces == minimax.score_spaces(unscored_spaces) }
#  end
#end



#describe 'Minimax choose' do
#  context 'when 7 is the only square left' do
#    Given(:board) { [ "O","O","X",
#                      "X","X","O",
#                      "O",nil,"X" ] }
#    When(:minimax) { Minimax.new }
#    When(:choice) { minimax.choose(board) }
#    Then { 7 == choice }
#  end
#
#  context 'when 3 is the only square left' do
#    Given(:board) { [ "O","X","O",
#                      nil,"X","O",
#                      "X","O","X" ] }
#    When(:minimax) { Minimax.new }
#    When(:choice) { minimax.choose(board) }
#    Then { 3 == choice }
#  end
#
#  context 'when 1 is the only square left' do
#    Given(:board) { [ "X",nil,"O",
#                      "O","X","X",
#                      "X","O","O" ] }
#    When(:minimax) { Minimax.new }
#    When(:choice) { minimax.choose(board) }
#    Then { 1 == choice }
#  end
#
#  context 'when 5 is the only square left' do
#    Given(:board) { [ "X","O","X",
#                      "O","X",nil,
#                      "O","X","O" ] }
#    When(:minimax) { Minimax.new }
#    When(:choice) { minimax.choose(board) }
#    Then { 5 == choice }
#  end
#
#  context 'when 4 is the only square left' do
#    Given(:board) { [ "X","O","X",
#                      "O",nil,"O",
#                      "X","O","X" ] }
#    When(:minimax) { Minimax.new }
#    When(:choice) { minimax.choose(board) }
#    Then { 4 == choice }
#  end
#
#  context 'when 0 is the only square left' do
#    Given(:board) { [ nil,"O","O",
#                      "X","X","O",
#                      "X","O","X" ] }
#    When(:minimax) { Minimax.new }
#    When(:choice) { minimax.choose(board) }
#    Then { 0 == choice }
#  end
#
#  context 'when 2 is the only square left' do
#    Given(:board) { [ "X","X",nil,
#                      "O","X","O",
#                      "X","O","O" ] }
#    When(:minimax) { Minimax.new }
#    When(:choice) { minimax.choose(board) }
#    Then { 2 == choice }
#  end
#
#  context 'when 8 is the only square left' do
#    Given(:board) { [ "X","O","X",
#                      "O","X","X",
#                      "O","O",nil ] }
#    When(:minimax) { Minimax.new }
#    When(:choice) { minimax.choose(board) }
#    Then { 8 == choice }
#  end
#
#  context 'when 6 is the only square left' do
#    Given(:board) { [ "O","O","X",
#                      "O","X","O",
#                      nil,"X","X" ] }
#    When(:minimax) { Minimax.new }
#    When(:choice) { minimax.choose(board) }
#    Then { 6 == choice }
#  end
#
#  context 'when one of two squares left will win the game' do
#    Given(:board) { [ "O","X",nil,
#                      "O","X","X",
#                      nil,"O","X" ] }
#    When(:minimax) { Minimax.new }
#    When(:choice) { minimax.choose(board) }
#    Then { 6 == choice }
#  end
#
#  context 'when another one of two squares left will win the game' do
#    Given(:board) { [ nil,"O","O",
#                      "O","X","X",
#                      "X","X",nil ] }
#    When(:minimax) { Minimax.new }
#    When(:choice) { minimax.choose(board) }
#    Then { 0 == choice }
#  end
#
#  context 'when one of four squares left will lose the game' do
#    Given(:board) { [ "O","X","X",
#                      nil,"O",nil,
#                      nil,nil,"X" ] }
#    When(:minimax) { Minimax.new }
#    When(:choice) { minimax.choose(board) }
#    Then { 5 == choice }
#  end
#
#  context 'when another one of four squares left will lose the game' do
#    Given(:board) { [ nil,nil,"O",
#                      nil,"O","X",
#                      "X",nil,"X" ] }
#    When(:minimax) { Minimax.new }
#    When(:choice) { minimax.choose(board) }
#    Then { 7 == choice }
#  end
#
#  context 'when one of five squares left will win the game' do
#    Given(:board) { [ "O",nil,"X",
#                      nil,"X",nil,
#                      "O",nil,"X" ] }
#    When(:minimax) { Minimax.new }
#    When(:choice) { minimax.choose(board) }
#    Then { 3 == choice }
#  end
#end
