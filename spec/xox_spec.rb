require 'rspec-given'
require 'xox'

describe 'XoxGame init' do
  Given(:subject) { XoxGame.new }
  Then { raise_error != subject }
end

describe 'XoxGame board' do
  context 'when a new game starts' do
    Given(:game) { XoxGame.new }
    When(:subject) { game.board }
    Then { [ "","","",
             "","","",
             "","","" ] == subject }
  end 
end
