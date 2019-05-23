class ScoresController < ApplicationController

  get '/scores/:id' do
    @score = Score.find(params[:id])
    @session = session
    erb :'/scores/show'
  end

end