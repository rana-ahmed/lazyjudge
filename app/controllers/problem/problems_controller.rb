class Problem::ProblemsController < ApplicationController
  before_action :set_problem, only: [:show]

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
