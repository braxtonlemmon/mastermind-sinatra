require "sinatra"
require "sinatra/reloader" if development?
# require needed files

get "/" do 
	erb :index
end