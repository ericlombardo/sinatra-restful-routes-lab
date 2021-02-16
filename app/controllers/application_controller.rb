class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # show all recipes w/ links
  get '/recipes' do 
    @recipes = Recipe.all
    erb :index
  end
  
  # show new recipe form
  get '/recipes/new' do
    erb :new
  end
  
  # recieve new recipe form, create new, redirect to specific recipe page
  post '/recipes' do
    recipe = Recipe.create(params)
    redirect "/recipes/#{recipe.id}"
  end

  # show individual recipe
  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    erb :show
  end

  # show form of specific recipe with info filled in
  get '/recipes/:id/edit' do  
    @recipe = Recipe.find(params[:id])
    
    erb :edit
  end

  # recieve edit form, update recipe, show specific recipe page
  patch '/recipes/:id' do
    params.delete('_method')
    
    recipe = Recipe.find(params[:id])
    recipe.update(params)
    
    redirect "/recipes/#{recipe.id}"
  end
  
  # delete specific recipe when button pressed
  delete '/recipes/:id' do 
    Recipe.find(params[:id]).destroy
  end

end
