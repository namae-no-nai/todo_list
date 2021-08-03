require 'json'

class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :your_task, only: %i[edit update destroy]

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
    if @task.update(task_params)
      reaction(@task) 
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

  def reaction(task)
    color = {"color-1": "#7B68EE", 
             "color-2": "#6A5ACD",
             "color-3": "#800000",
             "color-4": "#2F4F4F"}.to_a.sample
    if task.complete
      phrase = ["Great Work", "Awesome", "Mission complete", "Wowww", "Nice!!!"].sample
      @tracking = Tracking.create(event: "Congratulations", 
                                  properties: {
                                                phrase: phrase, 
                                                color: color[1]
                                              }.to_json
                                 )
    else
      phrase = ["Good grief", "Bummer", "Awefull", "Mission Failed", "Not nice"].sample
      @tracking = Tracking.create(event: "Shame", 
                                  properties: { 
                                                phrase: phrase, 
                                                color: color[1]
                                              }.to_json
                                 )
    end
    flash[color[0]] = phrase
  end

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
