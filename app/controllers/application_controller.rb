require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  use Rack::Flash, :sweep => true

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "data_req"
  end

  get "/" do
    erb :home
  end

  get '/' do
    available_posts
    if logged_in?
      #redirect '/tweets'
    else
      erb :home
    end
  end

  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      # redirect '/signup'
      fail_signup_msg
      redirect '/'
    else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id
      redirect '/posts'
    end
  end

  post '/login' do
    @user = User.find_by(params[:id])
    if @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      fail_login_msg
      redirect '/'
    end
  end

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end

    def fail_signup_msg
      flash[:fail_signup]='Sign up failed. Please complete all fields and press submit'
    end


    def fail_login_msg
      flash[:fail_login]='Log in failed. Please re-enter detail and try again'
    end

    def available_posts
      if 
    end
  end




end
