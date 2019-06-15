module Rules
	def show_rules
		puts rules =  
		<<~HEREDOC
			
			RULES
			
			The game consists of a codemaker and a codebreaker.
			You are the codebreaker and the computer is the codemaker. 
			There are six types of code pegs: [A] [B] [C] [D] [E] [F]
			There are two types of key pegs: [W] [Z]

			The codemaker will choose a hidden pattern of any combination of four code pegs.
			Duplicates can be included.
			For example, the codemaker might choose: [C] [A] [C] [F]

			The codebreaker has 12 attempts to correctly guess the hidden pattern. 
			After each guess,the codemaker will use the key pegs to give hints.
			Each [W] peg shown signifies a correct code peg in the right position.
			Each [Z] peg shown signifies a correct code peg, but in the wrong position.

			The codemaker receives one point for each attempt made by the codebreaker.

		HEREDOC
		
	end
end