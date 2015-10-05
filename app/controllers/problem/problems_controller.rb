class Problem::ProblemsController < ApplicationController
  before_action :set_problem, only: [:show, :destroy, :edit, :update]
  before_filter :login_required
  load_and_authorize_resource

  def index
    @problems = Problem.all
  end

  def new
    @problem = Problem.new
  end

  def create
    @problem = Problem.new(problem_params)

    if @problem.save
      redirect_to @problem, notice: "New problem added"
    else
      render :new
    end
  end

  def show

  end

  def edit

  end

  def update
    if @problem.update(problem_params)
      redirect_to @problem, notice: "Problem updated"
    else
      render :edit
    end
  end

  def destroy
    @problem.delete
    redirect_to problems_path
  end

  private
  def set_problem
    @problem = Problem.find(params[:id])
  end

  def problem_params
    params.require(:problem).permit(:title, :time_limit, :memory_limit, :description,
    :input_description, :output_description, :sample_input, :sample_output, :judge_input,
    :judge_output )
  end
end
