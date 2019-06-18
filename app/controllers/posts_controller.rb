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
    show_username
    if logged_in?
      erb :'/posts/new'
    else
      redirect '/'
    end
  end

  post '/posts' do
    if logged_in? && params[:title] != ""
      @post = Post.create(params[:post])
      @post.user = User.find_by(params[:id])
      @post.save

      redirect "/posts/#{@post.id}"
    else
      redirect '/'
    end
  end

  get '/posts/:id' do
    if logged_in?
      @post = Post.find(params[:id])
      erb :'/posts/show_post'
    else
      redirect '/'
    end
  end

  get '/posts/:id/post' do
    if logged_in?
      @post = Post.find_by(params[:id])
      erb :'/post/edit_post'
    else
      redirect '/'
    end
  end

  patch '/posts/:id' do
    @post = Post.find(params[:id])
    if params[:title]
      redirect "/posts/#{@post.id}/edit"
    else
      @post.update(params[:post])
      @post.save
      redirect "/posts/#{@post.id}"
    end
  end

  get '/posts/:id/edit' do
   if logged_in?
     @post = Post.find(params[:id])
     erb :'/posts/edit_post'
   else
     redirect '/'
   end
 end

delete '/posts/:id/delete' do
  if logged_in?
    @post = Post.find(params[:id])
    @post.delete
    erb :home
  else
    redirect "/"
  end
end

end
