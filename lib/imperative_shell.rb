class ImperativeShell

  def initialize(adapter)
    @adapter = adapter
    @playing = true
  end

  def play
    while @playing
      display(@adapter.render)
      choose_space
    end
  end

  def choose_space
    status = @adapter.relay(get_raw_input)
    @playing = status[:command]
    display(status[:message])
  end

  def display(message)
    puts message
  end

  def get_raw_input
    print "> "
    input = gets.chomp
  end
end
