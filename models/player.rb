#!/home/braxton/.rbenv/shims/ruby

class Player
	attr_accessor :name, :score
	
	def initialize(name)
		@name = name
		@score = 0
	end
end