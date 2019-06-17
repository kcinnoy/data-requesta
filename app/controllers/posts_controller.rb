class PostsController < ApplicationController

  get '/posts' do
    show_username
    if logged_in?
      erb :'/posts/all'
    else
      redirect '/'
    end
  end

  get '/posts/new' do
    if logged_in?
      erb :'/posts/new'
    else
      redirect '/'
    end
  end

  post '/posts' do
    if logged_in? && params[:title] != ""
      @post = Post.create( params[:post])
      @post.user = User.find_by(params[:id])
      @post.save

      redirect "/posts/#{@post.id}"
    else
      redirect '/login'
    end
  end

  get '/posts/:id' do
    if logged_in?
      @post = Tweet.find_by(params[:id])
      erb :'/posts/show_post'
    else
      redirect '/login'
    end
  end

  get '/posts/:id/post' do
    if logged_in?
      @post = Post.find_by(params[:id])
      erb :'/post/edit_post'
    else
      redirect '/login'
    end
  end

  patch '/posts/:id' do
    @tweet = Tweet.find_by(params[:id])
    if params[:content].empty?
      redirect "/posts/#{@post.id}/edit"
    else
      @post.update(content: params[:content])
      @post.save
      redirect "/posts/#{@post.id}"
    end
  end

  delete '/posts/:id/delete' do
    @post = Post.find_by(params[:id])
    @post.delete
    redirect '/posts'
  end
end
