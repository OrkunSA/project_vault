class UsersController < ApplicationController
    get '/signup' do 
        if  logged_in?
            redirect to '/projects'
        else
            erb :'users/signup'
        end
    end

    post '/signup' do
        user = User.new(params)
        if user.save
          session[:user_id] = user.id
          redirect '/projects'
        else
          redirect '/signup'
        end
    end

    get '/login' do 
        if logged_in?
            redirect  to '/projects'
        else
            erb :'/users/login'
        end
    end
    
    post '/login' do
        @current_user = User.find_by(:username => params[:username])
        if @current_user && @current_user.authenticate(params[:password])
            session[:user_id] = @current_user.id 
            redirect to '/projects'
        else
            redirect to '/signup'
        end
    end 

    get '/logout' do 
        if logged_in?
            session.clear 
            redirect to '/'
        else
            redirect to '/'
        end
    end

    
        
    get '/users/:slug' do 
        @user = User.find_by_slug(params[:slug])
        erb :'users/show'
    end



end