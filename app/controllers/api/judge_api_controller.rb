class Api::JudgeApiController < ApplicationController
  protect_from_forgery except: :result_api

  def result_api
    submission = Submission.where(reference: result_params[:reference]).take
    if submission
      already_solved = Submission.is_problem_solved(submission)
      if !(already_solved && (Submission.results[result_params[:result]] == Submission.results[:AC]))
        Submission.judge(submission, Submission.results[result_params[:result]])
      end
    end
    render nothing: true, status: 200
  end

  private
  def result_params
    params.require(:result).permit(:reference, :result)
  end
end
