require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    register Sinatra::Flash
    enable :sessions
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
      Student.find_by_id(session[:user_id])
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
