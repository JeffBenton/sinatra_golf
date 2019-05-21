class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "very secure"
  end

  get '/' do
    erb :'/application/login'
  end
end