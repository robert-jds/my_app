class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user, :only => :destroy

  def index 
    @users = User.all
    @user = current_user
    @body_class = 'user'
    @empty_notice = "No tasks assigned at this time."
  end

  def show
    @body_class = 'task'
    @user = User.find(params[:id])
    @all_users = User.all
    #@tasks = Task.find_by_assigned_to(@user.id)
    #@tasks = Task.find_all_by_assigned_to(@user.id, :conditions => "status != 2")
    @tasks = @user.assigned_tasks
    @empty_notice = "You have no assigned tasks at this time."
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

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end

  def completed 
    @body_class = 'task'
    @user = current_user
    @all_users = User.all
    @tasks = @user.assigned_tasks.find(:all, :conditions => "status = 2")
    @empty_notice = "No completed tasks here."
    @category = "completed"
    #render 'show'
  end

  def high_priority
    @body_class = 'task'
    @user = current_user
    @all_users = User.all
    @tasks = @user.assigned_tasks.find(:all, :conditions => "priority = 3")
    @empty_notice = "No high priority tasks here."
    @category = "high"
    #render 'show'
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

