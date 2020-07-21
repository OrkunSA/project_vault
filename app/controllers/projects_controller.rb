class ProjectsController < ApplicationController

    get '/projects' do 
        if logged_in?
            @user = current_user
            erb :'/projects/index'
        else
            redirect to '/login'
        end
    end
end

