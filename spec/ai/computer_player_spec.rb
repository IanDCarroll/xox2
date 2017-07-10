require 'spec_helper'
require 'rspec-given'
require 'ai/computer_player'
require 'board'
require 'game_constants'

describe 'ComputerPlayer init' do
  context 'when ComputerPlayer initializes' do
    Given(:computer) { ComputerPlayer.new(Board.new) }
    Then { raise_error != computer }
  end
end

describe 'ComputerPlayer pull_move' do
  context 'when pull_move is called at the start' do
    Given(:const) { GameConstants.new }
    Given(:status) { { message: const.new_game,
                       board: [ nil, nil, nil,
                                nil, nil, nil,
                                nil, nil, nil ] } }
    Given(:board) { Board.new }
    Given(:computer) { ComputerPlayer.new(board) }
    When { board.mark(1,"X") 
           board.mark(4,"O") 
           board.mark(3,"X") 
           board.mark(2,"O") 
           board.mark(5,"X") }
    When(:pulled_move) { computer.pull_move }
    Then { 0 == pulled_move }
  end
end
