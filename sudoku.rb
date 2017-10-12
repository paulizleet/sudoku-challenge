def solve(board_string)
  board = get_board(board_string)
  solved_board = solve_this_board(board)
end

def solve_this_board(board, row=0, col=0)
  #print "\e[2J"
  #puts pretty_board(board)
  #Time.sleep(0.1)
  coor = true
  until coor == false do
    coor = find_nil(board)

    if coor != false
      possibilities = find_possibilities(board, coor)
      return false if possibilities.empty?
      return(try_replace(board, coor, possibilities))
    end
  end
  board
end

def solved?(board)
  check_rows?(board) && check_columns?(board) && check_super_boxes?(board)
end

def check_rows?(board)
  valid_row = (1..9).to_a
  board.each { |row| return false if valid_row != row.sort }
  true
end

def check_columns?(board)
  return check_rows?(board.transpose)
end

def check_super_boxes?(board)
  valid_row = (1..9).to_a
   3.times do |i|
    3.times do |j|
    box = get_superbox(board, i, j)
    return false if valid_row != box.sort
   end
  end
  true
end

def pretty_board(board)
  output = ""
  board.each{|row|output += row.join(" ") + "\n"}
  output
end

def find_nil(board)
  board.each_with_index do |row, row_i|
    row.each_with_index do |cell, cell_i|
      return [row_i, cell_i] if cell.nil?
    end
  end
  false
end

def try_replace(board, coor, nums)
  is_solved = false

  nums.each do |num|
    board[coor[0]][coor[1]] = num
    is_solved = solve_this_board(board)
    break if is_solved != false
    board[coor[0]][coor[1]] = nil
  end
  is_solved
end

def find_possibilities(board, coor)
  nums = (1..9).to_a
  non_possibilities = get_row(board, coor[0]).reject{|cell| cell.nil?}
  non_possibilities += get_column(board, coor[1]).reject{|cell| cell.nil?}
  non_possibilities += get_superbox(board, coor[0] / 3, coor[1] / 3).reject{|cell| cell.nil?}
  nums = nums - non_possibilities
end

def get_board(board_string)
  new_board = []
  9.times do |i|
    row = board_string[(i*9)..((i*9) + 8)].chars
    new_board << row.map{|i| i == "-" ? nil : i.to_i}
  end
  new_board
end


def get_row(board, i)
  board[i]
end

def get_column(board, i)
  col = []
  board.each{|row| col << row[i]}
  col
end

def get_superbox(board, y, x)
  square = []
  return nil if x < 0 || x > 2 || y < 0 || y > 2

  3.times { |i| square << board[i+(3*y)][(3*x)..(3*x)+2] }
  square.flatten
end

def board_state(board)
  saved_board_state = []

  board.each do |row|
    new_row = []
    row.each do |cell|
      new_row << cell
    end
    saved_board_state << new_row
  end
  saved_board_state
end
