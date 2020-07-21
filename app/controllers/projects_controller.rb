class ProjectsController < ApplicationController

    get '/projects' do
        redirect_to_if_not_logged_in
        @projects = Project.all
          erb :'/projects/index'
    end

    get '/projects/new' do 
        redirect_to_if_not_logged_in
        erb :'/projects/new'
    end

    post '/projects' do
          @project = current_user.projects.create(params)
          if @project.save
            redirect '/projects'
          else
            redirect '/projects/new'
          end
    end
        
        
end

