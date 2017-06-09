require 'style'

class ImperativeShell

  def initialize(adapter)
    @style = Style.new
    @adapter = adapter
    @playing = true
    @play_again = true
  end

  def play
    while @playing
      display(@adapter.render)
      get_choice
      display(@message) 
    end
    play_again?
  end

  def play_again?
    if @play_again
      display(@style.play_again)
      if get_raw_input == 'start'
        @playing = true
        @adapter.relay("start")
        play
      else
        display(@style.farewell)
      end
    end
  end

  def get_choice 
    status = @adapter.relay(get_raw_input)
    @playing = status[:command][0]
    @play_again = status[:command][1]
    @message = status[:message]
  end

  def display(message)
    puts message
  end

  def get_raw_input
    print @style.prompt
    input = gets.chomp
  end
end
