class Problem::ProblemsController < ApplicationController
  def new
    @problem = Problem.new
  end
end
