class ComputerPlayer
  attr_accessor :status

  def push_status(status)
    @status = status
  end

  def pull_move
    choose_first_available_move
  end

  def choose_first_available_move
    (0..@status[:board].length).each do |i|
      empty_space = i + 1 
      if @status[:board][i] == empty_space.to_s
        return i
      end
    end
  end
end
