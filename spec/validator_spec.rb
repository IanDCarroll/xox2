require 'rspec-given'
require 'validator'

describe 'Validator init' do
  Given(:subject) { Validator.new }
  Then { raise_error != subject }
end

describe 'Validator valid?' do
  context 'when choice is valid' do
    Given(:board) { ["1","2","3","4","5","6","7","8","9"] }
    Given(:judge) { Validator.new}
    When(:subject) { judge.valid?(board, 0) }
    Then { 0 == subject }
  end

  context 'when another choice is valid' do
    Given(:board) { ["1","2","3","4","5","6","7","8","9"] }
    Given(:judge) { Validator.new}
    When(:subject) { judge.valid?(board, 8) }
    Then { 8 == subject }
  end
  
  context 'when a choice is too little' do
    Given(:board) { ["1","2","3","4","5","6","7","8","9"] }
    Given(:judge) { Validator.new}
    When(:subject) { judge.valid?(board, -1) }
    Then { false == subject }
  end

  context 'when a choice is too great' do
    Given(:board) { ["1","2","3","4","5","6","7","8","9"] }
    Given(:judge) { Validator.new}
    When(:subject) { judge.valid?(board, 10) }
    Then { false == subject }
  end

  context 'when a choice is taken' do
    Given(:board) { ["1","2","3","4","X","6","7","8","9"] }
    Given(:judge) { Validator.new}
    When(:subject) { judge.valid?(board, 4) }
    Then { false == subject }
  end
end
