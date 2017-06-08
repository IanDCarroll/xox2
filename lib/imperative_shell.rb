require 'style'

class ImperativeShell

  def initialize(adapter)
    @adapter = adapter
    @style = Style.new
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
      choice = @adapter.relay(input)
      display(choice)
      if game_over?(choice) 
        display(@adapter.render)
        @playing = false
      end
    end
  end

  def game_over?(choice)
    choice == @style.draw_message || choice.end_with?(@style.win_message) 
  end

  def not_want_to_exit?(input)
    @playing = input != @exit_command
  end 
end
