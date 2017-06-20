require 'rspec-given'
require 'cli/imperative_shell'

describe 'ImperativeShell init' do
  Given(:subject) { ImperativeShell.new }
  Then { raise_error != subject }
end
