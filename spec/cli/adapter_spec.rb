require 'rspec-given'
require 'cli/adapter'
require 'game_constants'

describe 'Adapter init' do
  Given(:status) { { board: Array.new, message: Array.new } }
  Given(:subject) { Adapter.new }
  Then { raise_error != subject } 
end

describe 'Adapter render_board' do
  context 'when render renders the first board' do
    Given(:board) { [ "1", "2", "3", "4", "5", "6", "7", "8", "9" ] }
    Given(:status) { { board: board, message: ["new", "game"] } }
    Given(:adapter) { Adapter.new }
    Given { adapter.push_status(status) }
    Then { " 1 | 2 | 3 \n---+---+---\n 4 | 5 | 6 \n---+---+---\n 7 | 8 | 9 " == adapter.render_board }
  end
end

describe 'Adapter relay' do
  context 'when relay passes information from the shell to the core' do
    Given(:const) { GameConstants.new }
    Given(:status) { {board: ["1","2","3",
                              "4","5","6",
                              "7","8","9"], 
                       message: const.new_game } }
    Given(:adapter) { Adapter.new }
    When(:subject) { adapter.push_status(status)
                     adapter.relay("5") }
    Then { 4 == subject }  
  end

  context 'when relay passes additional info from the shell to the core' do
    Given(:status) { {board: ["1","2","3",
                              "4","X","6",
                              "7","8","9"], 
                       message: [ "X", 4 ]} }
    Given(:adapter) { Adapter.new }
    When(:subject) { adapter.push_status(status)
                     adapter.relay("1") }
    Then { 0 == subject } 
  end

  context 'when relay passes a taken square from the shell to the core' do
    Given(:status) { {board: ["1","2","3",
                              "4","X","6",
                              "7","8","9"], 
                       message: [ "X", 4 ]} }
    Given(:adapter) { Adapter.new }
    When(:subject) { adapter.push_status(status)
                     adapter.relay("5") }
    Then { "error" == subject } 
  end


  context 'when relay passes a number too high' do
    Given(:status) { {board: ["1","2","3",
                              "4","X","6",
                              "7","8","9"], 
                       message: [ "X", 4 ]} }
    Given(:adapter) { Adapter.new }
    When(:subject) { adapter.push_status(status)
                     adapter.relay("10") }
    Then { "error" == subject } 
  end

  context 'when relay passes a number too low' do
    Given(:status) { {board: ["1","2","3",
                              "4","X","6",
                              "7","8","9"], 
                       message: [ "X", 4 ]} }
    Given(:adapter) { Adapter.new }
    When(:subject) { adapter.push_status(status)
                     adapter.relay("0") }
    Then { "error" == subject } 
  end


  context 'when relay passes a numberless string' do
    Given(:status) { {board: ["1","2","3",
                              "4","X","6",
                              "7","8","9"], 
                       message: [ "X", 4 ]} }
    Given(:adapter) { Adapter.new }
    When(:subject) { adapter.push_status(status)
                     adapter.relay("numberless string") }
    Then { "error" == subject } 
  end

  context 'when relay passes the start keyword' do
    Given(:status) { {board: ["1","2","3",
                              "4","X","6",
                              "7","8","9"], 
                       message: [ "X", 4 ]} }
    Given(:adapter) { Adapter.new }
    When(:subject) { adapter.push_status(status)
                     adapter.relay("start") }
    Then { "start" == subject } 
  end

  context 'when relay passes the exit keyword' do
    Given(:status) { {board: ["1","2","3",
                              "4","X","6",
                              "7","8","9"], 
                       message: [ "X", 4 ]} }
    Given(:adapter) { Adapter.new }
    When(:subject) { adapter.push_status(status)
                     adapter.relay("exit") }
    Then { "exit" == subject } 
  end
end

describe 'Adapter format_message' do
  context 'when format_message is passed a move message' do
    Given(:status) { {board: ["1","2","3",
                              "4","X","6",
                              "7","8","9"], 
                       message: [ "X", 4 ]} }
    Given(:adapter) { Adapter.new }
    When(:subject) { adapter.push_status(status)
                     adapter.format_message }
    Then { "X takes square 5" == subject }
  end

  context 'when format_message is passed a different move message' do
    Given(:status) { { message: [ "Spinal Tap", 10 ] } }
    Given(:adapter) { Adapter.new }
    When(:subject) { adapter.push_status(status) 
                     adapter.format_message }
    Then { "Spinal Tap takes square 11" == subject }
  end

  context 'when format_message is passed a draw message' do
    Given(:style) { Style.new }
    Given(:const) { GameConstants.new }
    Given(:status) { { message: const.draw } }
    Given(:adapter) { Adapter.new }
    When(:subject) { adapter.push_status(status)
                     adapter.format_message }
    Then { style.draw == subject }
  end

  context 'when format_message is passed a win message' do
    Given(:status) { { message: [ "X", "win" ] } }
    Given(:adapter) { Adapter.new }
    When(:subject) { adapter.push_status(status)
                     adapter.format_message }
    Then { "X wins the game!" == subject }
  end

  context 'when format_message is passed a different win message' do
    Given(:status) { { message: [ "Gryffindor", "win" ] } }
    Given(:adapter) { Adapter.new }
    When(:subject) { adapter.push_status(status)
                     adapter.format_message }
    Then { "Gryffindor wins the game!" == subject }
  end

  context 'when format_message is passsed a message to start a new game' do
    Given(:style) { Style.new }
    Given(:const) { GameConstants.new }
    Given(:status) { { message: const.new_game } }
    Given(:adapter) { Adapter.new }
    When(:subject) { adapter.push_status(status)
                     adapter.format_message }
    Then { style.new_game == subject }
  end

  context 'when format_message is passsed a message to end the game' do
    Given(:style) { Style.new }
    Given(:const) { GameConstants.new }
    Given(:status) { { message: const.end_game } }
    Given(:adapter) { Adapter.new }
    When(:subject) { adapter.push_status(status)
                     adapter.format_message }
    Then { style.end_game == subject }
  end

  context 'when format_message is passed an error message' do
    Given(:style) { Style.new }
    Given(:const) { GameConstants.new }
    Given(:status) { { message: const.bad_move } }
    Given(:adapter) { Adapter.new }
    When(:subject) { adapter.push_status(status)
                     adapter.format_message }
    Then { style.error == subject }
  end
end
