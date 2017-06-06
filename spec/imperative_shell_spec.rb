require 'rspec-given'
require 'imperative_shell'

describe 'XoxCli init' do
  Given(:subject) { ImperativeShell.new("fake adapter") }
  Then { raise_error != subject }
end

describe 'XoxCli want_to_exit?' do
  context 'when someone types "exit"' do
    Given(:subject) { ImperativeShell.new('fake adapter') }
    When(:exit?) { subject.not_want_to_exit?("exit") }
    Then { false == exit? }
  end

  context 'when someone does not type "exit"' do
    Given(:subject) { ImperativeShell.new('fake adapter') }
    When(:exit?) { subject.not_want_to_exit?("anything other than exit") }
    Then { true == exit? }
  end
end
