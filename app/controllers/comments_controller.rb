class CommentsController < ApplicationController
  def index
    @comments = Task.find(params[:task_id]).comments
    @comment = Comment.new()
    @task = Task.find(params[:task_id])
    @user = current_user
    @body_class = 'task'
  end

  def create
    @comment = Comment.new(params[:comment])
    if @comment.save
      flash[:success] = "Comment added!"
      redirect task_comments_path('index'
    else
      flash[:error] = "Error adding comment!"
      redirect @user
    end
  end
end
