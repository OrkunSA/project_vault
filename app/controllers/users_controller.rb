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
        if User.find_by(:username => user[:username])
            flash[:account_taken] = "The username you provided is already in our system. Please enter a new username or log in to continue."
            redirect to '/signup'
        elsif 
            User.find_by(:email => user[:email])
            flash[:email_taken] = "The email you provided is already in our system. Please enter a new email or log in to continue."
            redirect to '/signup'
        else
           if user.save 
            session[:user_id] = user.id 
            redirect to '/projects'
           else
            redirect to '/signup'
           end
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
        @current_user = User.find_by(:username => params[:username], :email => params[:email])
        if @current_user && @current_user.authenticate(params[:password]) 
            session[:user_id] = @current_user.id 
            redirect to '/projects'
        else
            if @current_user
                flash[:password] = "Oh-huh! You typed a wrong password, please try again"
                redirect to '/login'
            else
                flash[:no_account] = "There is no account associated with that email address. Please enter a different email or sign up for an account."
                redirect to '/login'
            end
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


end