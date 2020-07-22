class ProjectsController < ApplicationController
    
  #Loads index page
    get '/projects' do
        redirect_to_if_not_logged_in
        @user = current_user
        @projects = Project.all
          erb :'/projects/index'
    end
    
    #Loads new form
    get '/projects/new' do 
        redirect_to_if_not_logged_in
        erb :'/projects/new'
    end

    # Creates a project
    post '/projects' do
          @project = current_user.projects.create(params)
          if @project.save
            redirect '/projects'
          else
            redirect '/projects/new'
          end
    end
    
    #loads show page
    get '/projects/:id' do
      @user = current_user
      @project = Project.find(params[:id])
      erb :'/projects/show'
    end 
    
    #loads edit form
    get '/projects/:id/edit' do 
      redirect_to_if_not_logged_in
      @project = Project.find_by_id(params[:id])
      erb :'/projects/edit'
    end
    
    #Updates a project
    patch '/projects/:id/edit' do 
      redirect_to_if_not_logged_in
      @project = Project.find_by_id(params[:id])
      if logged_in? && @project.user_id == current_user.id 
      @project.title = params[:title]
      @project.description = params[:description]
      @project.platform = params[:platform]
      @project.programming_language = params[:programming_language]
      @project.start_date = params[:start_date]
      @project.end_date = params[:end_date]
      @project.save 
      redirect '/projects'
      else
      redirect "/projects/#{@project.id}/edit"
      end
    end
    
    #Deletes a project
    delete '/projects/:id/delete' do
      @project = Project.find_by_id(params[:id])
      if logged_in? && @project.user_id == current_user.id
        @project.destroy
      end
        redirect '/projects'
    end


        
end

