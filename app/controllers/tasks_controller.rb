class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy, :edit, :update]
 
  
  def show
    @task = Task.find(params[:id])
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'タスクが正常に投稿されました'
      redirect_to root_url
    else
      @tasks = current_user.feed_tasks.order("created_at DESC").page(params[:page])
      flash.now[:danger] = 'タスクが投稿されませんでした'
      render "toppages/index"
    end
  end
  
  def edit 
  end
  
  def update 
    
    if @task.update(task_params)
      flash[:success] = 'Task が正常に更新されました'
      redirect_to root_url
    else
      flash.now[:danger] = 'Task は更新されませんでした'
      render :edit
    end
  end
  
  def destroy
    @task.destroy
    flash[:success] = 'タスクを削除しました'
    redirect_to root_url
  end
  
  private
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
end
