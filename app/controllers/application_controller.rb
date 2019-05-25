class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
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
      redirect "/"
    end
  end

  post '/signup' do
    redirect "/signup" if params[:username].empty? || params[:email].empty? || params[:password].empty?

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