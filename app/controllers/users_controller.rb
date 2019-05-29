class UsersController < ApplicationController

  get '/users' do
    redirect '/' if !Helper.is_logged_in?(session)

    @session = session
    erb :'/users/index'
  end

  get '/users/:id' do
    redirect '/' if !Helper.is_logged_in?(session)

    @user = User.find_by_id(params[:id])

    if !@user
      flash[:user] = "The user you're looking for does not exist"
      redirect "/users"
    end

    @session = session
    erb :'/users/show'
  end

  patch '/users/:id/edit' do
    if params[:username].empty? || params[:email].empty?
      flash[:username] = "Username cannot be blank" if params[:username].empty?
      flash[:email] = "Email cannot be blank" if params[:email].empty?
    elsif !params[:email].match(URI::MailTo::EMAIL_REGEXP).present?
      flash[:email] = "Email must be valid"
    elsif User.find_by(email: params[:email]) && User.find_by(email: params[:email]).id != params[:id].to_i
      flash[:email] = "A user with that email already exists, please use a different one"
    elsif User.find_by(username: params[:username]) && User.find_by(username: params[:username]).id != params[:id].to_i
      flash[:username] = "A user with that username already exists, please choose a different one"
    end

    redirect "/users/#{params[:id]}/edit" if !flash.keep.empty?

    User.update(params[:id], username: params[:username], email: params[:email])
    redirect "/users/#{params[:id]}"
  end

  patch '/users/:id/edit_password' do
    if params[:current_password].empty? || params[:new_password].empty? || params[:new_password_confirm].empty?
      flash[:current_password] = "Current password cannot be empty" if params[:current_password].empty?
      flash[:new_password] = "New password cannot be empty" if params[:new_password].empty?
      flash[:new_password_confirm] = "Confirm new password cannot be empty" if params[:new_password_confirm].empty?
    elsif params[:current_password] == params[:new_password]
      flash[:password] = "The new password cannot be the same as your current password"
    end

    redirect "/users/#{params[:id]}/edit" if !flash.keep.empty?

    user = User.find(params[:id])
    if user.authenticate(params[:current_password]) && params[:new_password] == params[:new_password_confirm]
      User.update(params[:id], password: params[:new_password])
      redirect "/users/#{params[:id]}"
    else
      redirect "/users/#{params[:id]}/edit"
    end
  end

  get '/users/:id/edit' do
    redirect '/' if !Helper.is_logged_in?(session)

    @user = User.find_by_id(params[:id])

    if !@user
      flash[:user] = "The user you're looking for does not exist"
    elsif @user.id != params[:id]
      flash[:user] = "You do not have permission to edit that user"
    end

    redirect "users" if !flash.keep.empty?

    @session = session
    erb :'/users/edit'
  end

  delete '/users/:id/delete' do
    User.delete(params[:id])
    redirect "/users"
  end

  patch '/users/:id/admin' do
    User.update(params[:id], is_admin: true)
    redirect "/users"
  end
end