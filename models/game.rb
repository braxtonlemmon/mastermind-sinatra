#!/home/braxton/.rbenv/shims/ruby

require_relative 'board'
require_relative 'computer'
require_relative 'player'
require_relative 'rules'

class Game
	include Rules 

	attr_accessor :gameboard, :human, :computer, :answer, :guess, :history
	
	def initialize(gameboard = Board.new)
		@gameboard = gameboard
		@computer = Computer.new
		@answer = Array.new
		@human = false
		@history = Array.new
		@guess = Array.new(4)
		setup_game { show_rules }
	end

	def choose_role
		choice = 0
		until choice.between?(1,2)
			puts "Which role do you want?\nPress (1) to be CODEMAKER or press (2) to be CODEBREAKER"
			return choice = gets.chomp.to_i
		end
	end

	def setup_game
		puts "Welcome to Mastermind!\n\n"	
		puts "Would you like to see the rules? (y/n)"
		yield if gets.chomp.downcase[0] == 'y'
		puts "Ok. Please enter your name:"
		@human = Player.new(gets.chomp)
		puts "\nIt's #{human.name} versus the computer. Let's play!\n\n"
		choose_role == 1 ? play_as_codemaker : play_as_codebreaker
	end

	def play_as_codebreaker
		@human = true
		@answer = Array.new(4) { computer.random_peg }
		puts "\nYou are the codebreaker. Break the code!"
		loop_turns
		play_again? ? (game = Game.new) : return
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

	def loop_turns
		(1..12).each do |attempt_number|
			puts "This is attempt #{attempt_number}..."
			@human == true ? make_guess : (@guess = computer.generate_guess(@answer)) 
			check_guess
			show_history
			break if win?
		end
	end

	def make_guess
		try = []
		until try.size == 4 && try.all? { |x| x.match(/[A-F]/) }
			try = []
			puts "Please enter four letters to make a guess (A-F): "
			try = gets.chomp.upcase.split('')
		end
		puts "\nYou guessed:    [#{try.join(' | ')}]\n\n"
		@guess = try
	end

	def check_guess
			pegs = compare_guess_to_pattern
			@history << [guess, pegs]
	end

	def compare_guess_to_pattern
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

	def show_history
		puts "******************************************************************"
		history.each_with_index do |try, i|
			puts "Guess #{i+1}: [#{try[0].join(' | ')}].................Black pegs: #{try[1][0]} | White pegs: #{try[1][1]}"
		end
		puts "******************************************************************"
	end

	def win?
		guess == answer
	end

	def play_again?
		puts "Correct answer: [#{answer.join(' | ')}]"
		if @human == true
			puts win? ? "You win!" : "You lose."
		else
			puts win? ? "Computer wins." : "You win! Computer loses."
		end
		puts "Would you like to play again?"
		gets.chomp.downcase[0] == 'y' ? true : false
	end		
end

game = Game.new