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
    elsif params[:score_card].include?("")
      flash[:score_card] = "You must enter a score for every hole"
    end

    redirect "/scores/new" if !flash.keep.empty?

    score = Score.create(course_id: params[:course_id], score_card: params[:score_card].join(", "))
    Helper.current_user(session).scores << score
    redirect "/scores/#{score.id}"
  end

  get '/scores/:id/edit' do
    redirect "/" if !Helper.is_logged_in?(session)

    @score = Score.find_by_id(params[:id])

    if !@score
      flash[:score] = "The score you're looking for does not exist"
    elsif @score.user_id != Helper.current_user(session).id
      flash[:user] = "You do not have permission to edit this score"
    end

    redirect "/scores" if !flash.keep.empty?

    @session = session
    erb :"/scores/edit"
  end

  patch '/scores/:id/edit' do
    if params[:score_card].include?("")
      flash[:score_card] = "You must enter a score for every hole"
      redirect "/scores/#{params[:id]}/edit"
    end

    Score.update(params[:id], score_card: params[:score_card].join(", "))
    redirect "/scores/#{params[:id]}"
  end

  delete '/scores/:id/delete' do
    Score.delete(params[:id])
    redirect "/scores"
  end
end