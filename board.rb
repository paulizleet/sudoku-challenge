

class SudokuBoard
	include Enumerable


	def initialize(puzzle = nil)
		
		@board = []
		9.times { @board << Array.new(9){nil} }
		puzzle != nil ?	@board = load_puzzle(puzzle)
		
	end

	def load_puzzle(puzzle)

		new_board = []
		9.times {|i| new_board << puzzle[(i*9)..((i*9) + 8)].chars}
		new_board

	end

	def get_row(board, i)
		@board[i]
	end

	def get_column(board, i)
		col = []
		@board.each{|row| col << row[i]}
		col
	end

	def get_square(board, y, x)
		if x < 0 || x > 2 || y < 0 || y > 2
			p "invalid square"
			return nil
		end

		square = []

		3.times {|i|square << @board[i+(3*y)][(3*x)..(3*x)+2] }

		square
	end

	def each(&block)
		@board.each do |row|
			block.call(row)
		end
	end

end
