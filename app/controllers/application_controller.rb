require "./config/environment"
require "./app/models/recipe"
class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect to '/recipes'
  end

  # Display all recipes
  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  # Display new recipe form
  get '/recipes/new' do
    erb :new
  end

  # Create recipe by processing form data
  post '/recipes' do
    recipe = Recipe.create(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    redirect to "/recipes/#{recipe.id}"
  end

  # Display recipe created
  get '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    erb :show
  end

  # Display recipe edit form
  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by_id(params[:id])
    erb :edit
  end
 
  # Update recipe
  patch '/recipes/:id' do
    recipe = Recipe.find_by_id(params[:id])
    recipe.name = params[:name]
    recipe.ingredients = params[:ingredients]
    recipe.cook_time = params[:cook_time]
    recipe.save
    redirect to "/recipes/#{recipe.id}"
  end

  # Delete recipe
  delete '/recipes/:id/delete' do
    recipe = Recipe.find_by_id(params[:id])
    recipe.destroy
    redirect '/recipes'
  end

end
