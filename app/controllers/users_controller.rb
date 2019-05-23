class UsersController < ApplicationController

  get '/users/:id' do
    @user = User.find(params[:id])
    @session = session
    erb :'/users/show'
  end

  post '/users/:id/edit' do
    User.update(params[:id], username: params[:username], email: params[:email])
    redirect "/users/#{params[:id]}"
  end

  post '/users/:id/edit_password' do
    user = User.find(params[:id])
    if user.authenticate(params[:current_password]) && params[:new_password] == params[:new_password_confirm]
      User.update(params[:id], password: params[:new_password])
      redirect "/users/#{params[:id]}"
    else
      redirect "/users/#{params[:id]}/edit"
    end
  end

  get '/users/:id/edit' do
    @user = User.find(params[:id])
    @session = session
    erb :'/users/edit'
  end

end