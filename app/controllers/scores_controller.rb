class ScoresController < ApplicationController

  get '/scores' do
    redirect "/" if !Helper.is_logged_in?(session)

    @session = session
    erb :'/scores/index'
  end

  get '/scores/new' do
    redirect "/" if !Helper.is_logged_in?(session)

    @session = session
    erb :'/scores/new'
  end

  get '/scores/:id' do
    redirect "/" if !Helper.is_logged_in?(session)

    @score = Score.find_by_id(params[:id])

    if !@score
      flash[:score] = "The score you're looking for does not exist"
      redirect "/scores"
    end

    @session = session
    erb :'/scores/show'
  end

  post '/scores/new' do
    if !params.include?("course_id")
      flash[:course_id] = "Course selection cannot be empty"
      redirect "/scores/new"
    elsif params[:score_card].include?("")
      flash[:score_card] = "You must enter a score for every hole"
      redirect "/scores/new"
    end

    score = Score.create(course_id: params[:course_id], score_card: params[:score_card].join(", "))
    Helper.current_user(session).scores << score
    redirect "/scores/#{score.id}"
  end

  get '/scores/:id/edit' do
    redirect "/" if !Helper.is_logged_in?(session)

    @score = Score.find_by_id(params[:id])

    if !@score
      flash[:score] = "The score you're looking for does not exist"
      redirect "/scores"
    end

    @session = session
    erb :"/scores/edit"
  end

  post '/scores/:id/edit' do
    if params[:score_card].include?("")
      flash[:score_card] = "You must enter a score for every hole"
      redirect "/scores/#{params[:id]}/edit"
    end

    Score.update(params[:id], score_card: params[:score_card].join(", "))
    redirect "/scores/#{params[:id]}"
  end

  post '/scores/:id/delete' do
    Score.delete(params[:id])
    redirect "/scores"
  end
end