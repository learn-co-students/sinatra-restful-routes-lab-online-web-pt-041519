class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/recipes' do
    @recipes = Recipe.all
    # binding.pry
    erb :index
  end

  get '/recipes/new' do
    erb :new
  end

  post '/recipes' do
    @recipe = Recipe.create(params)
    redirect to "/recipes/#{@recipe.id}"
  end

  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    # binding.pry
    erb :show
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
    # binding.pry
    erb :edit
  end

  patch '/recipes/:id' do
    # binding.pry
    @recipe = Recipe.find(params[:id])
    @recipe.name = params[:name] if !params[:name].empty?
    @recipe.ingredients = params[:ingredients] if !params[:ingredients].empty?
    @recipe.cook_time = params[:cook_time] if !params[:cook_time].empty?
    @recipe.save

    redirect to "/recipes/#{@recipe.id}"
  end

  delete '/recipes/:id' do
    Recipe.all.delete(params[:id])

    erb :index
  end


end
