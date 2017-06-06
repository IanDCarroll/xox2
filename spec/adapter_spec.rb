require 'rspec-given'
require 'adapter'
require 'rules'
require 'board'

describe 'Adapter init' do
  Given(:board) { Board.new}
  Given(:subject) { Adapter.new(board, Rules.new(board)) }
  Then { raise_error != subject } 
end

describe 'Adapter render' do
  context 'when render renders the first board' do
    Given(:board) { Board.new}
    Given(:subject) { Adapter.new(board, Rules.new(board)) }
    Then { expect(subject.render).to be_a(String) }
    And  { " 1 | 2 | 3 \n---+---+---\n 4 | 5 | 6 \n---+---+---\n 7 | 8 | 9 " == subject.render }
  end
end

describe 'Adapter relay' do
  context 'when relay passes information from the shell to the core' do
    Given(:board) { Board.new}
    Given(:adapter) { Adapter.new(board, Rules.new(board)) }
    When(:subject) { adapter.relay("5") }
    Then { " 1 | 2 | 3 \n---+---+---\n 4 | X | 6 \n---+---+---\n 7 | 8 | 9 "== adapter.render }
  end

  context 'when relay passes additional info from the shell to the core' do
    Given(:board) { Board.new}
    Given(:adapter) { Adapter.new(board, Rules.new(board)) }
    When(:subject) { adapter.relay("5") 
                     adapter.relay("1") }
    Then { " O | 2 | 3 \n---+---+---\n 4 | X | 6 \n---+---+---\n 7 | 8 | 9 "== adapter.render }
  end
end
