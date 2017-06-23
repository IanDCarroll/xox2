class ComputerPlayer
  attr_accessor :status

  def push_status(status)
    @status = status
  end

  def pull_move
    choose_first_available_move
  end

  def choose_first_available_move
    @status[:board].length.times do |i|
      empty_space = i + 1 
      if @status[:board][i] == (i + 1).to_s then return i end
    end
  end
end
