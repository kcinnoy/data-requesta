class UsersController < ApplicationController


  # post '/signup' do
  #   if params[:username].empty? || params[:email].empty? || params[:password].empty?
  #     # redirect '/signup'
  #
  #   else
  #     @user = User.create(username: params[:username], email: params[:email], password: params[:password])
  #     session[:user_id] = @user.id
  #     redirect '/posts'
  #   end
  # end


  # post '/login' do
  #   @user = User.find_by(params[:id])
  #   if @user.authenticate(params[:password])
  #     session[:user_id] = @user.id
  #     redirect '/tweets'
  #   else
  #     redirect '/'
  #   end
  # end

  get '/profile' do
    show_username
    @current_user = current_user
    @user = @current_user
    show_username
    if logged_in?
      erb :'users/profile'
    else
      redirect '/'
    end
  end

  # post '/posts' do
  #   if logged_in? && params[:title] != ""
  #     @post = Post.create(params[:post])
  #     @post.user = @current_user
  #     @post.save
  #     puts "#{@post.user}"
  #     puts "#{@current_user.username}"
  #
  #     redirect "/posts/#{@post.id}"
  #   else
  #     redirect '/'
  #   end
  # end

  patch '/users/:id' do
        show_username
        current_user
      #  if params[:username] || params[:password]
        if false
           redirect '/users/profile'
       else
           @user = User.find_by(:id => params[:id])
           @user.update(params[:user])
           erb :'users/profile'
       end
   end


  get '/logout' do
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

  get '/users/:slug' do
    @user = User.find_by(params[:id])

    erb :'/users/profile'
  end

end
