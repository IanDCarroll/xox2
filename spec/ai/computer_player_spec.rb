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
    Given(:computer) { ComputerPlayer.new(Board.new) }
    When(:pulled_move) { computer.pull_move }
    Then { 0 == pulled_move }
  end
end
