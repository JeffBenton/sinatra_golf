class CoursesController < ApplicationController

  get '/courses' do
    @session = session
    erb :'/courses/index'
  end

  get '/courses/new' do
    @session = session
    erb :'/courses/new'
  end

  get '/courses/:id' do
    @course = Course.find(params[:id])
    @session = session
    erb :'/courses/show'
  end

  get '/courses/:id/edit' do
    @course = Course.find(params[:id])
    @session = session
    erb :'/courses/edit'
  end

  post '/courses/new' do
    course = Course.create(name: params[:name], score_card: params[:score_card].join(", "))
    redirect "/courses/#{course.id}"
  end

  post '/courses/:id/delete' do
    Course.delete(params[:id])
    redirect "/courses"
  end

  post '/courses/:id/edit' do
    Course.update(params[:id], name: params[:name], score_card: params[:score_card].join(", "))
    redirect "/courses/#{params[:id]}"
  end

end