require 'style'

class ImperativeShell

  def initialize
    @style = Style.new
  end

  def display(string)
    puts string
  end

  def get_user_input
    print @style.prompt
    gets.chomp
  end
end
