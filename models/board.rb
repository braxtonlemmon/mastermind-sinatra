#!/home/braxton/.rbenv/shims/ruby

class Board
	attr_accessor :board
	
	def initialize
		@board = Array.new(12) { Array.new(4) }
	end
end