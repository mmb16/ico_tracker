require './config/environment'
class ApplicationController < Sinatra::Base
    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
        enable :sessions
        set :session_secret, "password_security"
    end

    get '/' do
        erb :index
    end

    helpers do
   def logged_in?
     !!current_user
   end

   def current_user
     @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
   end
 end

  get '/signup' do
    if logged_in?
      redirect to '/icos'
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    if params["username"] != "" && params["password"] != ""
      @user = User.create(params)
      @user.save
      session[:user_id] = @user.id
      redirect to '/icos'
    end
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
