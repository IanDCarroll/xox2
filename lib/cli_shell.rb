require_relative 'cli_adapter'

class XoxCli

  def initialize(adapter = Adapter.new)
    @adapter = adapter
  end

  def display
    puts @adapter.render
  end

  def choose_space
    print "> "
    gets.chomp
  end 
end
