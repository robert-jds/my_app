class CommentsController < ApplicationController
  def index
    @comments = Task.find(params[:task_id]).comments
    @comment = Comment.new()
    @task = Task.find(params[:task_id])
    @user = current_user
    @body_class = 'task'
  end

  def create
    @comment = current_user.comments.create(params[:comment])
    if @comment.save
      flash[:success] = "Comment added!"
      redirect_to task_comments_path(params[:comment][:task_id])
    else
      flash[:error] = "Error adding comment!"
      redirect_to @user
    end
  end

end
