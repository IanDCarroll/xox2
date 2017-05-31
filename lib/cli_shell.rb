class XoxCli

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

  def display(message)
    puts message
  end

  def choose_space
    print "> "
    input = gets.chomp
    if not want_to_exit?(input)
      display(@adapter.relay(input))
    end
  end

  def want_to_exit?(input)
    if input == "exit"
      @playing = false
      return true
    end
    false
  end 
end
