class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    register Sinatra::Flash
    set :session_secret, "very secure"
  end

  get '/' do
    redirect '/home' if Helper.is_logged_in?(session)

    @session = session
    erb :'/application/login'
  end

  get '/signup' do
    redirect '/home' if Helper.is_logged_in?(session)

    @session = session
    erb :'/application/signup'
  end

  get '/home' do
    redirect '/' if !Helper.is_logged_in?(session)

    @user = Helper.current_user(session)
    @session = session
    erb :'/application/index'
  end

  get '/logout' do
    session.clear
    redirect "/"
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/home'
    else
      flash[:credentials] = "Incorrect username and/or password."
      redirect "/"
    end
  end

  post '/signup' do
    redirect "/signup" if params[:username].empty? || params[:email].empty? || params[:password].empty?

    if User.find_by(email: params[:email])
      flash[:email] = "A user with that email already exists, please use a different one."
      redirect "/signup"
    elsif User.find_by(username: params[:username])
      flash[:username] = "A user with that username already exists, please choose a different one."
      redirect "/signup"
    end

    user = User.new(params)

    if user.save
      user.is_admin = true if User.all.length == 1
      session[:user_id] = user.id
      redirect "/home"
    else
      redirect "/signup"
    end
  end
end