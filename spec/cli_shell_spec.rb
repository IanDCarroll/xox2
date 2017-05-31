require 'rspec-given'
require 'cli_shell'
require 'cli_adapter'

describe 'XoxCli init' do
  Given(:subject) { XoxCli.new("fake adapter") }
  Then { raise_error != subject }
end

describe 'XoxCli want_to_exit?' do
  context 'when someone types "exit"' do
    Given(:subject) { XoxCli.new('fake adapter') }
    When(:exit?) { subject.want_to_exit?("exit") }
    Then { true == exit? }
  end

  context 'when someone does not type "exit"' do
    Given(:subject) { XoxCli.new('fake adapter') }
    When(:exit?) { subject.want_to_exit?("anything other than exit") }
    Then { false == exit? }
  end
end
