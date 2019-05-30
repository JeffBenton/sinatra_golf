# require 'uri'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    use Rack::Flash
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
    redirect '/' if !Helper.is_logged_in?(session)

    session.clear
    redirect "/"
  end

  post '/login' do
    redirect '/home' if Helper.is_logged_in?(session)

    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/home'
    else
      flash[:credentials] = "Incorrect username and/or password"
      redirect "/"
    end
  end

  post '/signup' do
    redirect '/home' if Helper.is_logged_in?(session)

    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      flash[:username] = "Username cannot be blank" if params[:username].empty?
      flash[:email] = "Email cannot be blank" if params[:email].empty?
      flash[:password] = "Password cannot be blank" if params[:password].empty?
    elsif !params[:email].match(URI::MailTo::EMAIL_REGEXP).present?
      flash[:email] = "Email must be valid"
    elsif User.find_by(email: params[:email])
      flash[:email] = "A user with that email already exists, please use a different one"
    elsif User.find_by(username: params[:username])
      flash[:username] = "A user with that username already exists, please choose a different one"
    end
    binding.pry
    redirect "/signup" if !flash.keys.empty?

    user = User.new(params)
    user.is_admin = true if User.all.length == 0

    if user.save
      session[:user_id] = user.id
      redirect "/home"
    else
      redirect "/signup"
    end
  end
end