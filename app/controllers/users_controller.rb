class UsersController < ApplicationController


  get '/profile' do
    @current_user = current_user
    @user = @current_user
    if logged_in?
      erb :'users/profile'
    else
      redirect '/'
    end
  end


  patch '/users/:id' do
        @user = current_user
        if params[:user][:username].empty? || params[:user][:email].empty?
           erb :'users/profile'
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
