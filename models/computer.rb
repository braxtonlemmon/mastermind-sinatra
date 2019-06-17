class Computer
	attr_accessor :guess, :final

	def initialize
		@guess = Array.new(4)
		@final = Array.new(4)
	end

	def random_peg
		["A", "B", "C", "D", "E", "F"].sample
	end

	def generate_guess(answer)
		try = Array.new(4)
		final.each_with_index { |x, i| try[i] = x.nil? ? random_peg : x }
		(0..3).each { |i| (final[i] = try[i]) if (answer[i] == try[i])}	
		try
	end
end
