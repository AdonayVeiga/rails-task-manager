class TasksController < ApplicationController
  before_action :task_find, only: %i[edit update show destroy]
  def index
    @tasks = Task.all
  end

  def show; end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:success] = 'Task successfully created'
      redirect_to @task
    else
      flash[:error] = 'Something went wrong'
      render 'new'
    end
  end

  def edit; end

  def update
    # @task = Task.find(params[:id])
    if @task.update_attributes(update_task_param)
      flash[:success] = 'Task was successfully updated'
      redirect_to tasks_path
    else
      flash[:error] = 'Something went wrong'
      render 'edit'
    end
  end

  def destroy
    # @task = Task.find(params[:id])
    # raise
    if @task.destroy
      flash[:success] = 'Task was successfully deleted.'
    else
      flash[:error] = 'Something went wrong'
    end
    redirect_to tasks_path
  end

  private

  def task_params
    params.require(:task).permit(:title, :details)
  end

  def update_task_param
    params.require(:task).permit(:title, :details, :completed)
  end

  def task_find
    @task = Task.find(params[:id])
  end
end
