require 'spec_helper'
require 'rspec-given'
require 'board'

describe 'Board spaces' do
  context 'by default has 9 spaces' do
    Given(:board) { Board.new }
    Then { [nil, nil, nil,
            nil, nil, nil,
            nil, nil, nil] == board.spaces }
  end
end

describe 'Board mark' do
  context 'when a mark is made' do
    Given(:board) { Board.new }
    When { board.mark(5, "X") }
    Then { [ nil, nil, nil,
             nil, nil, "X",
             nil, nil, nil ] == board.spaces }
  end

  context 'when 2 different marks are made' do
    Given(:board) { Board.new }
    When { board.mark(5, "X")
           board.mark(1, "O") }
    Then { [ nil, "O", nil,
             nil, nil, "X",
             nil, nil, nil ] == board.spaces }
  end
end

describe 'Board available spaces' do
  context 'lists the spaces that are available to mark' do
    Given(:board) { Board.new }
    Then { [0, 1, 2,
            3, 4, 5,
            6, 7, 8] == board.available_spaces }
  end

  context 'lists the spaces that are available to mark after the board has been marked somewhere' do
    Given(:board) { Board.new }
    When { board.mark(4, "J") }
    Then { [0, 1, 2,
            3,    5,
            6, 7, 8] == board.available_spaces }
  end
end


describe 'Board erase_marks' do
  context 'When board has been marked and a new game is started' do
    Given(:board) { Board.new }
    When { board.mark(4, "X") }
    Then { [nil, nil, nil,
            nil, nil, nil,
            nil, nil, nil] == board.erase_marks }
  end

end
