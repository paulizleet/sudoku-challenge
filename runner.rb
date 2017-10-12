require_relative 'sudoku'
require "benchmark"

# The sudoku puzzles that your program will solve can be found
# in the sudoku_puzzles.txt file.
#
# Currently, Line 18 defines the variable board_string to equal
# the first puzzle (i.e., the first line in the .txt file).
# After your program can solve this first puzzle, edit
# the code below, so that the program tries to solve
# all of the puzzles.
#
# Remember, the file has newline characters at the end of each line,
# so we call String#chomp to remove them.

board_string = File.readlines('sudoku_puzzles.txt')


now = Time.now
num_puzzle = 0
board_string.each do |board_string|
  begin
  num_puzzle+=1
  s_time = Time.now
  solved_board = solve(board_string.chomp)
  f_time = Time.now
    if solved?(solved_board)
      puts "\n#{num_puzzle}  The board was solved in #{f_time-s_time}"
      puts pretty_board(solved_board)
    else
      puts "The board wasn't solved :("
    end
  rescue
    puts "This is not a valid sudoku board."
  end

end

puts "Finished in #{Time.now - now}"
