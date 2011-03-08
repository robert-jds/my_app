class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user, :only => :destroy

  def index 
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    #@tasks = Task.find_by_assigned_to(@user.id)
    @tasks = @user.assigned_tasks
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
    # params[:user].merge({ :name => "BOB" })
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end

  def high_priority
    @user = current_user
    @tasks = @user.assigned_tasks.find(:all, :conditions => "priority = 1")
    render 'show'
  end

  private
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end

