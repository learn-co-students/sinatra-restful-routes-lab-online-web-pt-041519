class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!
  get "/" do
   redirect to "/recipes"
  end

  get "/recipes/new" do
     erb :"new"
  end

  get "/recipes" do
    @recipes = Recipe.all
    erb :"index"
  end
 #/SHOW  display a single article.access the ID of the article in the
 #view through the params hash.
  get "/recipes/:id" do
    @recipe = Recipe.find_by_id(params[:id])
    erb :"show"
  end

  get "/recipes/:id/edit" do
    @recipe = Recipe.find_by_id(params[:id])
    erb :"edit"
  end

  #UPDATE
  patch "/recipes/:id" do # I KEEP FORGETTING SLASH
   @recipe = Recipe.find_by_id(params[:id])
   @recipe.name = params[:name]
   @recipe.ingredients = params[:ingredients]
   @recipe.cook_time = params[:cook_time]

   @recipe.save
   redirect to "/recipes/#{@recipe.id}"
  end

  #NEW recipes
  post "/recipes" do #didnt pass cuz of wrong route.i added new
  #@recipe = Recipe.create(recipe: params[:name], recipe: params[:ingredients], recipe: params[:cook_time])
    @recipe = Recipe.create(params)
    redirect to "/recipes/#{@recipe.id}"
  end

  #delete
  delete '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.delete
    redirect to '/recipes'
  end

end
