class UsersController < ApplicationController

  get '/users/:id' do
    @user = User.find(params[:id])
    @session = session
    erb :'/users/show'
  end

end