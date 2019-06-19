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

  get '/' do
    current_user
    available_posts
    show_username
    if logged_in?
      erb :home
    else
      erb :home
    end
  end

  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      fail_signup_msg
      redirect '/'
    else
      @username = params[:username]
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id
      redirect '/posts'
    end
  end

  post '/login' do
    # @username = params[:username]
    # @user = User.find_by(params[:user_id])
    # if @user.authenticate(params[:password])
    #   session[:user_id] = @user.id
    #   redirect '/posts'
    @user = User.find_by(:username => params[:username])
       if @user && @user.authenticate(params[:password])
           session[:user_id] = @user.id
           redirect '/posts'
    else
      fail_login_msg
      redirect '/'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/'
    else
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

    def show_username
      if logged_in?
        @show_user = @current_user.username
      else
        @show_user = ""
      end
    end


    def fail_signup_msg
      flash[:fail_signup]='Sign up failed. Please complete all fields and press submit'
    end


    def fail_login_msg
      flash[:fail_login]='Log in failed. Please re-enter detail and try again'
    end

    def available_posts
      if Post.all.empty?
        @posts_available = ' No posts availablex'
      end
    end

    def post_username
      @user_id_ = @post.user_id
      @user_id_n = User.find(params[user_id_])
      @user_name_ = @user_id_n.username
    end

    def allow_edit?
      puts "c_user#{@current_user.id}"
      puts "user:#{@post.user_id}"
      @allowed
      if @current_user.id == @post.user_id
        @allowed = true
      else
        @allowed = false
      end
    end

    
  end




end
