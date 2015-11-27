class Problem::SubmissionsController < ApplicationController
  before_filter :login_required
  load_and_authorize_resource except: :create
  before_action :contest_not_running, only: [:new, :create, :update, :edit]

  def index
    if params[:ref] == "my_submission"
      @submissions = Submission.where(user_id: current_user.id)
      @show_id = true
    else
      @submissions = Submission.all
    end

  end

  def new
    @submission = current_user.submissions.build
  end

  def create
    @submission = current_user.submissions.build(new_submission_params)
    authorize! :create, @submission
    if @submission.save
      reference = @submission.id.to_s + @submission.problem_id.to_s + 'new'
      @submission.reference = Digest::MD5.hexdigest(reference)
      if @submission.save
        #making the http request to server
        redirect_to submissions_path, notice: "Problem submitted"
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
    if @submission.update(update_submission_params) && @submission.update(reference: current_user.id)
      redirect_to submissions_path, notice: "Rejudge complete"
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

  def contest_not_running
    if Setting.contest_running.nil?
      redirect_to :back, notice: "Contest is not running"
    end
  end
end