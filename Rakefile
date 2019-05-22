require_relative './config/environment'

require 'sinatra/activerecord/rake'

task :console do
  Pry.start
end

task :clear do
  User.delete_all
  Course.delete_all
  Score.delete_all
end