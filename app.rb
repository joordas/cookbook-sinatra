require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require 'csv'
set :bind, '0.0.0.0'
require_relative "models/recipe"
require_relative "models/parser"

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

get '/' do
   erb :index
end

get '/list' do
  @recipes = CSV.open('data/recipes.csv').read
  erb :list
end

get '/create' do
  erb :create
end

post '/create' do
  @recipes = CSV.open('data/recipes.csv').read
  new_recipe = Recipe.new(params)
  @recipes << [new_recipe.name, new_recipe.description, new_recipe.cooking_time, false, new_recipe.difficulty]

  CSV.open('data/recipes.csv', "wb") do |csv|
      @recipes.map do |recipe|
        csv << [recipe[0], recipe[1], recipe[2], recipe[3] == true ? 'true' : 'false', recipe[4]]
      end
    end
  redirect '/list'
end

get '/import' do
  erb :import
end

post '/import' do

  redirect "import/#{params[:keyword]}"
end

get "/import/:keyword" do
  parser = Parser.new(params[:keyword])
  return parser.get_recipes
  erb :import_list
end




# get '/team/:username' do
#   puts params[:username]
#   "The username is #{params[:username]}"
# end
