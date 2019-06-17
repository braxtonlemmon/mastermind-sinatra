#!/home/braxton/.rbenv/shims/ruby

require_relative 'computer'

class Game


	attr_accessor :board, :computer, :answer, :guess, :turn
	
	def initialize
		@board = Array.new(12) { Array.new(6) { "_" } }
		@computer = Computer.new
		@answer = Array.new(4) { computer.random_peg }
		@codebreaker = false
		@turn = 0
		@guess = Array.new(4)
	end


	def play_as_codemaker
		until answer.size == 4 && answer.all? { |x| x.match(/[A-F]/) }
			puts "\nYou are the codemaker. Enter any four-letter combination of the letters [ A | B | C | D | E | F ]: "
			@answer = gets.chomp.upcase.split('')
		end
		puts "This is the secret code: [#{answer.join(" | ")}]\nThe computer will now attempt to guess your code..."
		loop_turns
		play_again? ? (game = Game.new) : return
	end

	def game_over?
		win? || @turn == 12
	end

  # updates board after each guess
	def record_guess(try)
		(0..3).each { |i| @board[@turn][i] = try[i] }
		results = determine_guess_results
		@board[@turn][4] = results[0]
		@board[@turn][5] = results[1]
		@turn += 1
	end

	# converts params to array after each guess
	def convert_guess(params)
		@guess = []
		params.each { |key, value| @guess << value }
		@guess
	end

	# finds number of white and black pegs after each guess
	def determine_guess_results
		b_pegs = 0
		w_pegs = 0
		key = answer.uniq
		key.each_with_index do |letter|
			if answer.count(letter) == guess.count(letter)
				w_pegs += answer.count(letter)
			elsif answer.count(letter) > guess.count(letter)
				w_pegs += guess.count(letter)
			elsif answer.count(letter) < guess.count(letter)
				w_pegs += answer.count(letter)
			end
		end
		(0..3).each do |i|
			if answer[i] == guess[i]	
				b_pegs += 1
				w_pegs -= 1
			end
		end
		[b_pegs, w_pegs]
	end

	def win?
		@guess == @answer
	end
end
