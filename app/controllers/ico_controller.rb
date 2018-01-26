
class IcoController < ApplicationController
get '/icos' do
  if logged_in?
    @user = User.find_by_id(session[:user_id])
    @icos = Ico.all
    erb :'/icos/icos'
  else
    redirect to '/login'
  end
end

get '/icos/new' do
  if logged_in?
    erb :'/icos/create_ico'
  else
    redirect to '/login'
  end
end

post '/icos/new' do
  if logged_in?
    if params[:name] != ""
      @ico = Ico.create(params)
      @ico.user_id = session[:user_id]
      @ico.save
    end
    redirect to "/icos/#{@ico.id}"
  else
    redirect to '/login'
  end
end

get "/users/:slug" do
  erb :'/users/show'
end

get "/icos/:id" do
  if logged_in?
    @ico = Ico.find_by_id(params[:id])
    erb :'/icos/show_ico'
  else
    redirect to '/login'
  end
end

get "/icos/:id/edit" do
  if logged_in?
    @ico = Ico.find_by_id(params[:id])
    erb :'/icos/edit_ico'
  else
    redirect to '/login'
  end
end

post "/icos/:id/edit" do
  if logged_in?
    if params[:name] != ""
      @ico = Ico.find_by_id(params[:id])
      @ico.name = params[:name]
      @ico.save
    end
    redirect to "/icos/#{@ico.id}"
  else
    redirect to '/login'
  end
end

get "/icos/:id/delete" do
  if logged_in?
    @ico = Ico.find_by_id(params[:id])
    if @ico.user_id == session[:user_id]
      @ico.delete
    end
    redirect to '/icos'
  else
    redirect to '/login'
  end
end

end
