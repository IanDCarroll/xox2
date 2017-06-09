require 'rspec-given'
require 'imperative_shell'

describe 'XoxCli init' do
  Given(:subject) { ImperativeShell.new("fake adapter", "fake rules") }
  Then { raise_error != subject }
end
