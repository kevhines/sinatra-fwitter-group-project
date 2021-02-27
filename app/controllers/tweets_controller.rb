class TweetsController < ApplicationController

    get '/tweets' do
        if logged_in?
            @tweets = Tweet.all
            erb :'tweets/index'
          else
            redirect to '/login'
          end
    end

    get '/tweets/new' do
        if logged_in?
            erb :'/tweets/new'
          else
            redirect to '/login'
          end
    end

    post '/tweets' do
       # binding.pry
        if logged_in?
            if params[:content] == ""
              redirect to "/tweets/new"
            else
              @tweet = current_user.tweets.build(content: params[:content])
              if @tweet.save
                redirect to "/tweets/#{@tweet.id}" # left off here
              else
                redirect to "/tweets/new"
              end
            end
        else
            redirect to '/login'
        end  
    end

    get '/tweets/:id' do
        if logged_in?
          @tweet = Tweet.find_by_id(params[:id])
          erb :'tweets/show'
        else
          redirect to '/login'
        end
      end

      patch '/tweets/:id' do
        @tweet = Tweet.find_by_id(params[:id])
        if logged_in?
            if params[:content] == ""
              redirect to "/tweets/#{@tweet.id}/edit"
            else
              @tweet.update(content: params[:content])
            end
        else
            redirect to '/login'
        end  
      end

    get '/tweets/:id/edit' do
        if logged_in?
            @tweet = Tweet.find_by_id(params[:id])
            # binding.pry
            if current_user.tweets.include?(@tweet)
                erb :'/tweets/edit'
            else
                #binding.pry
                redirect to "/tweets/#{@tweet.id}"
            end
        else
            redirect to '/login'
        end
    end

    delete '/tweets/:id/delete' do
        if logged_in?
            @tweet = Tweet.find_by_id(params[:id])
            # binding.pry
            if current_user.tweets.include?(@tweet)
                @tweet.destroy
                redirect to "/tweets"
            else
                redirect to "/tweets/#{@tweet.id}"
            end
        else
            redirect to '/login'
        end
    end


end
