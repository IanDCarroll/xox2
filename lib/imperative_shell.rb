require 'style'

class ImperativeShell

  def initialize(adapter, rules)
    @adapter = adapter
    @rules = rules
    @style = Style.new
    @playing = true
    @exit_command = 'exit'
  end

  def play
    while @playing
      display(@adapter.render)
      choose_space
    end
    print "Good game!\nType \"yes\" to play again. "
    input = gets.chomp
    if input == 'yes'
      @rules.reset
      @playing = true
      play
    else
      display("Thanks for playing!")
    end
  end

  def display(message)
    puts message
  end

  def choose_space
    print "> "
    input = gets.chomp
    exit_command?(input)
    choice = @adapter.relay(input)
    display(choice)
    if game_over?(choice) 
      display(@adapter.render)
      @playing = false
    end
  end

  def game_over?(choice)
    choice == @style.draw_message || choice.end_with?(@style.win_message) 
  end

  def exit_command?(input)
    if input == @exit_command
      display("Thanks for playing!")
      exit
    end
  end 
end
