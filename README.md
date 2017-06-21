[![Build Status](https://travis-ci.org/IanDCarroll/xox2.svg?branch=master)](https://travis-ci.org/IanDCarroll/xox2) [![Coverage Status](https://coveralls.io/repos/github/IanDCarroll/xox2/badge.svg?branch=master)](https://coveralls.io/github/IanDCarroll/xox2?branch=master)
# xox2
A PvP Noughts and Crosses Game

## Name origin
The game is named after a contender for the first video game, OXO by Sandy Douglas at Cabridge University in 1952. This being the second construction, it is xox2. The 2 can also be a reference to the fact that unlike the first [xox](https://github.com/IanDCarroll/xox), this one is PvP.

## Ruby Version and Gem Dependencies
Xox uses RVM and Bundle to manage the environment.</br>
The project runs on Ruby 2.4.1. The .rvmrc file is configured to automatically switches to that Ruby version with a seprate Gemset called `xox` when you enter the project's root directory.</br>
The gem dependencies are `guard-rspec` and `rspec-given` for test-driving the code.

## How to Install and Run the Game
To install:</br>
Clone the Repo and `cd` into the project's root directory.</br>
`$ bundle`
 
To run:</br>
`$ ruby start_xox.rb`

## How to Run the Tests
In a separate terminal window:</br>
`$ guard`</br>
The tests should run automatically whenever you save the source code or the test suite.</br>
Hit `ENTER` to run the tests manually, or (in a separate window):</br> 
`$ rspec`

to exit guard:</br>
`> exit`
