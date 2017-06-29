require 'ai/minimax'

class ComputerPlayer
  attr_accessor :status

  def push_status(status)
    @status = status
    @ai = Minimax.new
  end

  def pull_move
    # @ai.choose(@status[:board]) # for when it works again
    choose_first_available_move
  end

  def choose_first_available_move
    @status[:board].length.times do |i|
      if @status[:board][i] == nil then return i end
    end
  end
end
