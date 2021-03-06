class PostsController < ApplicationController

  get '/posts' do
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
    if logged_in?
      if params[:post][:title].empty? || params[:post][:description].empty?
        redirect '/posts/new'
      else
        @post = Post.create(params[:post])
        @post.user = @current_user
        @post.save
        puts "#{@post.user}"
        puts "#{@current_user.username}"
        redirect "/posts/#{@post.id}"
      end
    else
      redirect '/'
    end
  end

  get '/posts/:id' do
    redirect_if_not_logged_in
      @post = Post.find(params[:id])
      @user_n = User.find(@post.user_id).username
      erb :'/posts/show_post'
  end

  # get '/posts/:id/post' do
  #   if logged_in?
  #     @post = Post.find_by(params[:id])
  #     erb :'/post/edit_post'
  #   else
  #     redirect '/'
  #   end
  # end




  patch '/posts/:id' do
    @post = Post.find(params[:id])
    if params[:post][:title].empty? || params[:post][:description].empty?
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
    #  if current_user.id == @post.user_id
    if allow_edit?
       erb :'/posts/edit_post'
     else
       puts "flash message"
       redirect '/'
    end
   else
     redirect '/'
   end
 end

delete '/posts/:id/delete' do
  redirect_if_not_logged_in
    @post = Post.find(params[:id])
    if allow_edit?
      @post.delete
      redirect "/"
    else
      redirect "/"
    end
end

#
# delete '/posts/:id/delete' do
#   if logged_in?
#     @post = Post.find(params[:id])
#     if allow_edit?
#       @post.delete
#       redirect "/"
#     else
#       redirect "/"
#     end
#   else
#     redirect "/"
#   end
# end

end
