class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :your_task, only: %i[edit destroy]

  def index
    @tasks = Task.where(user: current_user)
  end
  
  def new
    @task = Task.new
  end

  def create
    @task = Task.create(task_params)
    @task.user = current_user
    if @task.save
      redirect_to root_path
    else
      flash[:notice] = "Description can't be blank"
      render :new 
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    your_task
    if @task.update(task_params)
      redirect_to root_path
    else
      flash[:notice] = "Description can't be blank"
      render :edit 
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to root_path
  end
  
  private

  def your_task
    @task = Task.find(params[:id])
    if current_user != @task.user
      flash[:notice] = "That task is not yours"
      redirect_to root_path
    end
  end


  def task_params
    params.require(:task).permit(:description, :complete)
  end
  
end
