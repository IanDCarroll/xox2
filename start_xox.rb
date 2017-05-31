require_relative 'lib/board'
require_relative 'lib/xox'
require_relative 'lib/cli_adapter'
require_relative 'lib/cli_shell'

board = Board.new
game = XoxGame.new(board)
adapter = Adapter.new(board, game)
shell = XoxCli.new(adapter)

shell.play
