class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update]
  before_filter :correct_user, :only => [:edit, :update]

  def index 
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @title = "Sign up"
    @user = User.new()
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to JagTasks!"
      redirect_to @user
    else
      @title = "Sign up"
      @user.password = ''
      @user.password_confirmation = ''
      render 'new'
    end
  end

  def edit
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
    def authenticate
      deny_access unless signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
end

