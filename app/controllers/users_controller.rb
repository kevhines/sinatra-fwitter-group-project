class UsersController < ApplicationController

    get '/signup' do
        if logged_in?
            redirect to '/tweets'
        else
            erb :'users/new'
        end
    end

    post '/signup' do
        if params[:username] == "" || params[:email] == "" || params[:password] == ""
            redirect to '/signup'
          else
            #binding.pry
            @user = User.create(params)
            session[:user_id] = @user.id
           # binding.pry
            redirect to '/tweets'
          end    
    end

    get '/login' do
        if logged_in?
            redirect to '/tweets'
        else
            erb :'users/login'
        end
    end

    post '/login' do
        user = User.find_by(:username => params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect to "/tweets"
          else
            redirect to '/signup'
          end
    end

    get '/logout' do
        session.destroy
        redirect to '/login'
    end

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
      #  binding.pry
        erb :'users/show'
    end



end
