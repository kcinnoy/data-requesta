class PostsController < ApplicationController

  get '/posts' do
    if logged_in?
      erb :'/posts/all'
    else
      redirect '/'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if logged_in? && params[:content] != ""
      @tweet = Tweet.create(content: params[:content])
      @tweet.user = User.find_by(params[:id])
      @tweet.save

      redirect "/tweets/#{@tweet.id}"
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by(params[:id])
      erb :'/tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by(params[:id])
    if params[:content].empty?
      redirect "/tweets/#{@tweet.id}/edit"
    else
      @tweet.update(content: params[:content])
      @tweet.save
      redirect "/tweets/#{@tweet.id}"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by(params[:id])
    @tweet.delete
    redirect '/tweets'
  end
end
