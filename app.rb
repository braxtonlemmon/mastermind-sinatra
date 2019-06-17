require "sinatra"
require "sinatra/reloader" if development?
require "./models/game"

enable :sessions

get "/" do
	session.delete(:game)
	erb :index
end

post "/" do
	role = params[:role] == "break" ? :codebreaker : :codemaker
	session[:game] = Game.new
  redirect role
end

get "/codemaker" do
	erb :codemaker
end

get "/codebreaker" do
	@board = session[:game].board
	game = session[:game]
	if game.game_over?
		@stop = true 
		@message = game.win? ? "Victory!" : "Wah wah, game lost."
	end
  erb :codebreaker
end

post "/codebreaker" do
	game = session[:game]
	pegs = game.convert_guess(params)
	game.record_guess(pegs)

	redirect :codebreaker
end





