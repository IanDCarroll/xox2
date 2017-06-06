class ImperativeShell

  def initialize(adapter)
    @adapter = adapter
    @playing = true
    @exit_command = 'exit'
  end

  def play
    while @playing
      display(@adapter.render)
      choose_space
    end
  end

  def display(message)
    puts message
  end

  def choose_space
    print "> "
    input = gets.chomp
    if not_want_to_exit?(input)
      display(@adapter.relay(input))
    end
  end

  def not_want_to_exit?(input)
    @playing = input != @exit_command
  end 
end
