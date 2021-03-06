class CoursesController < ApplicationController

  get '/courses' do
    redirect "/" if !Helper.is_logged_in?(session)

    @session = session
    erb :'/courses/index'
  end

  get '/courses/new' do
    redirect "/" if !Helper.is_logged_in?(session)

    @session = session
    erb :'/courses/new'
  end

  get '/courses/:id' do
    redirect "/" if !Helper.is_logged_in?(session)

    @course = Course.find_by_id(params[:id])

    if !@course
      flash[:course] = "The course you're looking for does not exist"
      redirect "/courses"
    end

    @session = session
    erb :'/courses/show'
  end

  get '/courses/:id/edit' do
    redirect "/" if !Helper.is_logged_in?(session)

    @course = Course.find_by_id(params[:id])

    if !@course
      flash[:error] = "The course you're looking for does not exist"
    elsif !Helper.current_user(session).is_admin
      flash[:error] = "You do not have permission to edit courses"
    end

    redirect "/courses" if flash.keys.include?(:error)

    @session = session
    erb :'/courses/edit'
  end

  post '/courses/new' do
    redirect "/" if !Helper.is_logged_in?(session)

    if params[:name].empty?
      flash[:name] = "Course name cannot be blank"
    elsif params[:score_card].include?("")
      flash[:score] = "You must enter a par for each hole."
    elsif Course.find_by(name: params[:name])
      flash[:exists] = "A course with that name already exists"
    end

    redirect "/courses/new" if !flash.keys.empty?

    course = Course.create(name: params[:name], score_card: params[:score_card].join(", "))
    redirect "/courses/#{course.id}"
  end

  delete '/courses/:id' do
    redirect "/" if !Helper.is_logged_in?(session)

    if !Helper.current_user(session).is_admin
      flash[:admin] = "You don't have permission to do that"
      redirect "/home"
    end

    Course.delete(params[:id])
    Score.where(course_id: params[:id]).destroy_all
    redirect "/courses"
  end

  patch '/courses/:id' do
    redirect "/" if !Helper.is_logged_in?(session)

    if !Helper.current_user(session).is_admin
      flash[:admin] = "You don't have permission to do that"
      redirect "/home"
    elsif params[:name].empty?
      flash[:name] = "Course name cannot be blank"
    elsif params[:score_card].include?("")
      flash[:score_card] = "You must enter a par for every hole"
    elsif Course.find_by(name: params[:name]) && Course.find_by(name: params[:name]).id != params[:id].to_i
      flash[:exists] = "A course with that name already exists"
    end

    redirect "/courses/#{params[:id]}/edit" if !flash.keys.empty?

    Course.update(params[:id], name: params[:name], score_card: params[:score_card].join(", "))
    redirect "/courses/#{params[:id]}"
  end

  get '/*' do
    redirect "/" if !Helper.is_logged_in?(session)

    @session = session
    erb :'/catchall'
  end
end