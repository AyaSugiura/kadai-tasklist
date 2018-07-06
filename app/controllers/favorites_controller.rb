class FavoritesController < ApplicationController
  def create
    task = Task.find(params[:task_id])
    current_user.like(task)
    flash[:success] = "いいねしました♪"
    redirect_back(fallback_location: root_path)
  end

  def destroy
    task = Task.find(params[:task_id])
    current_user.unlike(task)
    flash[:success] = "いいねを解除しました"
    redirect_back(fallback_location: root_path)
  end
end
