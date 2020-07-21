require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    register Sinatra::Flash
    set :session_secret, "Yabba Dabba Doo"
  end

  

  get "/" do
    if logged_in?
      redirect to '/projects'
    else
    erb :index
    end
  end

  helpers do 

    def logged_in? 
      !!session[:user_id]
    end

    def current_user
      User.find_by_id(session[:user_id])
    end

    def is_empty?(user_hash, route)
      user_hash.each do |att, val|
        if val.empty?
          flash[:empty] = "Uh-oh! You need to complete all fields to move on."
          redirect to "/#{route}"
        end
      end
    end
  end

end
