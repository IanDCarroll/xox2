require 'rspec-given'
require 'cli_adapter'

describe 'Adapter init' do
  Given(:subject) { Adapter.new }
  Then { raise_error != subject } 
end

describe 'Adapter render' do
  context 'when render renders the first board' do
    Given(:subject) { Adapter.new }
    Then { expect(subject.render).to be_a(String) }
    And  { " 1 | 2 | 3 \n---+---+---\n 4 | 5 | 6 \n---+---+---\n 7 | 8 | 9 " == subject.render }
  end
end
