class StudentsController < ApplicationController
    get '/signup' do 
        if  logged_in?
            redirect to '/projects'
        else
            erb :'students/signup'
        end
    end
end