class UserController < ApplicationController

get '/signup' do
  if logged_in?
    redirect to '/icos'
  else
    erb :'/users/create_user'
  end
end

post '/signup' do
  if params["username"] != "" && params["email"] != "" && params["password"] != ""
    @user = User.create(params)
    @user.save
    session[:user_id] = @user.id
    redirect to '/icos'
  end
  "Please fill in all fields"
  redirect to '/signup'
end

get '/login' do
  if logged_in?
    redirect to '/icos'
  else
    erb :'/users/login'
  end
end

post '/login' do
  @user = User.find_by(username: params[:username])
  session[:user_id] = @user.id
  redirect to '/icos'
end

get '/logout' do
  session.clear
  redirect to '/login'
end
end
