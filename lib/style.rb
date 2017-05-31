class Style
  attr_reader :wall
  attr_reader :shelf
  attr_reader :padding

  def initialize
    @wall = " | "
    @shelf = "\n---+---+---\n"
    @padding = " " 
  end
end
