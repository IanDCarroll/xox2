require 'game_constants'
require 'reporter'

class Minimax
  attr_writer :board

  def initialize
    @const = GameConstants.new
    @judge = Reporter.new
    @recursion_depth = 0
    @max_mark = @const.players[1]
    @max_score = 1
    @choices = []
    @legal_moves = []
  end

  def choose(board)
    board = board.dup
    recurse_through_game_tree(board)
  end

  def recurse_through_game_tree(board)
    @recursion_depth += 1 # parallel recursions are making the count go wrong.
    p 'recursion_depth ' + @recursion_depth.to_s
    choices = evaluate_choices(board)
    #p choices
    choice = pick_the_best_choice(choices)
    p 'surfacing from recursion_depth ' + @recursion_depth.to_s
    @recursion_depth -= 1 # an attempt to undo parallel recusions
    choice
  end

  def evaluate_choices(board)
    available_spaces(board).each do |space|
      evaluate_choice(board, space, @choices)
    end
    @choices
  end

  def available_spaces(board = @board)
    @legal_moves[@recursion_depth - 1] = []
    scoped_legal_moves = @legal_moves[@recursion_depth -1]
    board.length.times do |i|
      board[i] == (i + 1).to_s ? scoped_legal_moves << i : nil
      p "legal_moves " + @legal_moves.to_s
    end
    p 'using legal_moves in index ' + (@recursion_depth -1).to_s
    scoped_legal_moves
  end

  def evaluate_choice(board, space, choices)
    p 'original board ' + board.to_s
    p 'modified_board ' + modified_board(board, space).to_s 
    p 'evaluating space ' + space.to_s
    p 'choices prior' + choices.to_s
    p 'sim_report ' + sim_report(board, space).to_s
    if sim_report(board, space) == [ @const.players[1], @const.win ]
      choices[space] = @max_score
      p 'choices O win' + choices.to_s
    elsif sim_report(board, space) == [ @const.players[0], @const.win ]
      choices[space] = -@max_score
      p 'choices X win' + choices.to_s
    elsif sim_report(board, space) == @const.draw
      choices[space] = 0
      p 'choices drawn' + choices.to_s
    else
      p 'no endgame for space '+ space.to_s + '. recursing...'
      recurse_through_game_tree(modified_board(board, space)) 
    end
  end

  def sim_report(board, space)
    @judge.report({ board: modified_board(board, space), 
                    player: mark,
                    space: space })
  end

  def mark
    @recursion_depth % 2 == 1 ? @const.players[1] : @const.players[0]
  end

  def modified_board(board, space)
    board = board.dup
    board[space] = mark
    board
  end

  def pick_the_best_choice(choices)
    if @recursion_depth % 2 == 1
      pick_the_max_choice(choices)
    elsif @recursion_depth % 2 == 0
      pick_the_min_choice(choices)
    end
  end

  def pick_the_min_choice(choices)
    #p mark
    best_score = @max_score
    best_choice = nil 
    choices.each do |choice|
      unless choice == nil
        if choice <= best_score
          best_score = choice
          best_choice = choices.index(choice) 
        end
      end
    end
    p 'enemy ' + @recursion_depth.to_s + " chooses " + best_choice.to_s
    best_choice
  end

  def pick_the_max_choice(choices)
    #p mark
    best_score = -@max_score
    best_choice = nil 
    choices.each do |choice|
      unless choice == nil
        if choice >= best_score
          best_score = choice
          best_choice = choices.index(choice) 
        end
      end
    end 
    p 'selfy ' + @recursion_depth.to_s + " chooses " + best_choice.to_s
    best_choice
  end
end
