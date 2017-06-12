$: << File.expand_path(File.dirname(__FILE__)) + '/lib'

require 'board'
require 'rules'
require 'game_runner'
require 'imperative_shell'

board = Board.new
rules = Rules.new(board)
game_runner = GameRunner.new(board, rules)

game_runner.start_game
