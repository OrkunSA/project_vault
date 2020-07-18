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
      redirect to '/students/index'
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
  end

end
