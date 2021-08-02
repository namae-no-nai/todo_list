class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :your_task, only: :edit

  def index
    @tasks = Task.all
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


  private

  def your_task
    @task = Task.find(params[:id])
    if current_user != @task.user
      redirect_to root_path
      flash[:alert] = "That task is not yours"
    end
  end


  def task_params
    params.require(:task).permit(:description, :complete)
  end
  
end
