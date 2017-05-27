require 'rspec-given'
require 'cli_shell'

describe 'XoxCli init' do
  Given(:subject) { XoxCli.new }
  Then { raise_error != subject }
end
