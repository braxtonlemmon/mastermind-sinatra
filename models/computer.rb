#!/home/braxton/.rbenv/shims/ruby

class Computer
	attr_accessor :score, :guess, :final

	CODE_PEGS = {
		0 => "A",
		1 => "B",
		2 => "C",
		3 => "D",
		4 => "E",
		5 => "F"
	}

	def initialize
		@score = 0
		@guess = Array.new(4)
		@final = Array.new(4)
	end

	def random_peg
		letter = CODE_PEGS[rand(6)]
	end

	def generate_guess(answer)
		try = Array.new(4)
		final.each_with_index { |x, i| x.nil? ? (try[i] = random_peg) : (try[i] = x) }
		(0..3).each { |i| (final[i] = try[i]) if (answer[i] == try[i])}	
		return try
	end

end
