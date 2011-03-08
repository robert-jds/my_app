class TasksController < ApplicationController
  before_filter :authenticate
  before_filter :correct_user, :only => [:edit, :update]

  def show
    @user = current_user
    @tasks = @user.assigned_tasks
    @task = Task.find(params[:id])
  end

  def create
    # TODO
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
      render 'pages/home'
    end
  end

  def edit
    @task = Task.find(params[:id])
    @users = []
    User.all.each do |u|
      @users << [u.name, u.id]
    end
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
