require "sinatra"
require "sinatra/reloader" if development?
require "./models/game"


enable :sessions

get "/" do
	session.delete(:game)
	erb :index
end

post "/" do
	session[:game] = Game.new(params[:role])
	redirect params[:role]
end

get "/codemaker" do
	game = session[:game]
	@board = game.board
	if game.game_over?
		@stop = true 
		@message = game.win? ? "Computer wins!" : "You beat the computer!"
	end
	erb :codemaker
end

post "/codemaker" do
	game = session[:game]
	until game.game_over?
		game.computer_play(params)
  end
	redirect :codemaker
end

get "/codebreaker" do
	game = session[:game]
	@board = game.board
	if game.game_over?
		@stop = true 
		@answer = game.answer
		@message = game.win? ? "You guessed it!" : "Wah wah, game lost."
	end
  erb :codebreaker
end

post "/codebreaker" do
	game = session[:game]
	pegs = game.convert_guess(params)
	game.record_guess(pegs)
	redirect :codebreaker
end







