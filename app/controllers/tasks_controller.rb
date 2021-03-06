class TasksController < ApplicationController
  before_filter :authenticate
  before_filter :correct_user, :only => [:edit, :update]

  def show
    @body_class = 'task'
    @user = User.find(params[:user_id])
    @all_users = User.all
    @tasks = @user.assigned_tasks
    @selected_task = Task.find(params[:id])
    @empty_notice = "You have no assigned tasks at this time."
    if params[:category] == "high"
      @category = "high"
      @tasks = @user.assigned_tasks.find(:all, :conditions => "priority = 3")
      @empty_notice = "No high priority tasks here."
      render 'users/high_priority'
    elsif params[:category] == "completed"
      @category = "completed"
      @tasks = @user.assigned_tasks.find(:all, :conditions => "status = 2")
      @empty_notice = "No completed tasks here."
      render 'users/completed'
    end
  end

  def create
    # TODO add time
    #params[:task][:due_date] = DateTime.parse(params[:task][:due_date])
    @task = current_user.assigned_by_me_tasks.build(params[:task])
    @users = []
    User.all.each do |u|
      @users << [u.name, u.id]
    end
    @users.empty? ? @default = '' : @default = @users[0][1]
    if @task.save
      flash[:success] = "Task created!"
      redirect_to root_path
    else
      @priorities = [['high', 3],['medium', 2],['low', 1]]
      @default_priority = 2
      render 'pages/home'
    end
  end

  def edit
    @body_class = 'task'
    @task = Task.find(params[:id])
    @users = []
    User.all.each do |u|
      @users << [u.name, u.id]
    end
    @priorities = [['high', 3],['medium', 2],['low', 1]]
    @default_priority = @task.priority.nil? ? 2 : @task.priority
    @status = [['Complete', 2],['In-progress', 1]]
    @default_status = @task.status.nil? ? 1 : @task.status
    @default = @task.assigned_to
  end

  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(params[:task])
      flash[:success] = "Task updated."
      redirect_to current_user
    else
      render 'edit'
    end
  end

  def destroy
    @task = Task.find(params[:id])
    if @task.destroy
      flash[:success] = "Task deleted!"
    else
      flash[:error] = "Problem deleting task!"
    end

    redirect_to current_user 
  end

  private
    def correct_user
      if !current_user?(User.find(Task.find(params[:id]).assigned_by))
        flash[:notice] = "Sorry, you can't edit a task that you didn't assign."
        redirect_to(root_path) 
      end
    end
end
