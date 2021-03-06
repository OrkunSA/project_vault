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
      @project = Project.find_by_id(params[:id])
      if @project
      erb :'/projects/show'
      else 
        flash[:fail] = "You don't have that project in your vault"
        redirect '/projects'
      end
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
      @project.save 
      redirect "/projects/#{@project.id}"
    else
      redirect '/projects'
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

