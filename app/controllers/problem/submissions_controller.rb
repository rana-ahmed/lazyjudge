class Problem::SubmissionsController < ApplicationController
  require "#{Rails.root}/lib/judging"

  before_filter :login_required
  load_and_authorize_resource except: :create
  before_action :contest_not_running, only: [:new, :create]

  def index
    if params[:ref] == "my_submission"
      @submissions = Submission.where(user_id: current_user.id).order("created_at DESC")
      @show_id = true
    else
      @submissions = Submission.all.order("created_at DESC")
    end

  end

  def new
    @submission = current_user.submissions.build
  end

  def create
    @submission = current_user.submissions.build(new_submission_params)
    if Submission.is_problem_solved(@submission)
      redirect_to :back, notice: "Problem already solved" and return
    end
    authorize! :create, @submission
    if @submission.save
      reference = @submission.id.to_s + @submission.problem_id.to_s + 'new'
      @submission.reference = Digest::MD5.hexdigest(reference)
      if @submission.save
        #making the http request to server
        redirect_to submissions_path(ref: "my_submission"), notice: "Problem submitted"
      else
        redirect_to :back, notice: "Server has some internal problem"
      end
    else
      render :new
    end
  end

  def edit
    @submission = Submission.find(params[:id])
  end

  def update
    already_solved = Submission.is_problem_solved(@submission)
    if already_solved && (Submission.results[update_submission_params[:result]] == Submission.results[:AC])
      redirect_to edit_submission_path(@submission), notice: "Problem already solved" and return
    elsif Submission.judge(@submission, Submission.results[update_submission_params[:result]])
      redirect_to submissions_path, notice: "Rejudge complete" and return
    else
      render :edit, notice: "There is some problem to rejudge"
    end
  end

  private
  def new_submission_params
    params.require(:submission).permit(:problem_id, :language, :code)
  end

  def update_submission_params
    params.require(:submission).permit(:result)
  end
end
