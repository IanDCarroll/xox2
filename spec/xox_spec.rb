require 'rspec-given'
require 'xox'

describe 'XoxGame init' do
  Given(:subject) { XoxGame.new }
  Then { raise_error != subject }
end
