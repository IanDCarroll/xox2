require 'spec_helper'
require 'rspec-given'
require 'game_constants'
require 'ai/computer_player'

describe 'ComputerPlayer init' do
  context 'when ComputerPlayer initializes' do
    Given(:computer) { ComputerPlayer.new }
    Then { raise_error != computer }
  end
end

describe 'ComputerPlayer pull_move' do
  context 'when pull_move is called at the start' do
    Given(:const) { GameConstants.new }
    Given(:status) { { message: const.new_game,
                       board: [ "1", "2", "3",
                                "4", "5", "6",
                                "7", "8", "9" ] } }
    Given(:computer) { ComputerPlayer.new }
    When(:pulled_move) { computer.push_status(status)
                         computer.pull_move }
    Then { 0 == pulled_move }
  end
end

describe 'ComputerPlayer push_status' do
  context 'when a new status is pushed to the computer' do
    Given(:const) { GameConstants.new }
    Given(:status) { { message: const.new_game,
                       board: [ "1", "2", "3",
                                "4", "5", "6",
                                "7", "8", "9" ] } }
    Given(:computer) { ComputerPlayer.new }
    When(:pushed_status) { computer.push_status(status) }
    Then { computer.status = pushed_status }   
  end
end
