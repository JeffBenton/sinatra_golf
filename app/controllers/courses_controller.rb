class CoursesController < ApplicationController

  get '/courses/:id' do
    @course = Course.find(params[:id])
    @session = session
    erb :'/courses/show'
  end

end