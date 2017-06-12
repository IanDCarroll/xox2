$: << File.expand_path(File.dirname(__FILE__)) + '/lib'

require 'board'
require 'rules'
require 'cli/adapter'
require 'game_runner'

board = Board.new
rules = Rules.new(board)
shell_adapter = Adapter.new
game_runner = GameRunner.new(board, rules, shell_adapter)

game_runner.start_game
