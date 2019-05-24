class ScoresController < ApplicationController

  get '/scores' do
    @session = session
    erb :'/scores/index'
  end

  get '/scores/new' do
    @session = session
    erb :'/scores/new'
  end

  get '/scores/:id' do
    @score = Score.find(params[:id])
    @session = session
    erb :'/scores/show'
  end

  post '/scores/new' do
    score = Score.create(course_id: params[:course_id], score_card: params[:score_card].join(", "))
    Helper.current_user(session).scores << score
    redirect "/scores/#{score.id}"
  end

  get '/scores/:id/edit' do
    @score = Score.find(params[:id])
    @session = session
    erb :"/scores/edit"
  end

  post '/scores/:id/edit' do
    Score.update(params[:id], score_card: params[:score_card].join(", "))
    redirect "/scores/#{params[:id]}"
  end

  post '/scores/:id/delete' do
    Score.delete(params[:id])
    redirect "/scores"
  end
end