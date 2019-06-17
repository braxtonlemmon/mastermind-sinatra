require_relative 'computer'

class Game

	attr_accessor :board, :computer, :answer, :guess, :turn
	
	def initialize(role)
		@board = Array.new(12) { Array.new(6) { "_" } }
		@computer = Computer.new
		@answer = role == "codebreaker" ? (Array.new(4) { computer.random_peg }) : nil
		@turn = 0
		@guess = Array.new(4)
	end

	def computer_play(params)
		@answer = convert_guess(params)
    @guess = computer.generate_guess(@answer)
	  record_guess(@guess)
	end

	def game_over?
		win? || @turn == 12
	end

	def record_guess(try)
		(0..3).each { |i| @board[@turn][i] = try[i] }
		results = determine_guess_results
		@board[@turn][4] = results[0]
		@board[@turn][5] = results[1]
		@turn += 1
	end

	def convert_guess(params)
		@guess = []
		params.each { |key, value| @guess << value }
		@guess
	end

	# TODO: refactor and split into smaller methods
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
