class TasksController < ApplicationController
  before_action :authenticate_user!

  def index
    @tasks = Task.all
  end
  
  def new
    @task = Task.new
  end

  def create
    @task = Task.create(list_params)
    @task.user = current_user
    if @task.save
      redirect_to root_path
    else
      flash[:notice] = "Description can't be blank"
      render :new 
    end
  end

  private

  def list_params
    params.require(:task).permit(:description, :complete)
  end
  
end
