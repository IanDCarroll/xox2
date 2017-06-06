$: << File.expand_path(File.dirname(__FILE__)) + '/lib'

require 'board'
require 'rules'
require 'adapter'
require 'imperative_shell'

board = Board.new
rules = Rules.new(board)
adapter = Adapter.new(board, rules)
shell = ImperativeShell.new(adapter)

shell.play
