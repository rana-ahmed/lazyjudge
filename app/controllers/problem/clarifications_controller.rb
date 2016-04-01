class Problem::ClarificationsController < ApplicationController
  before_filter :login_required
  before_action :set_clarification, only: [:destroy, :edit, :update]
  before_action :contest_not_running, only: [:new]
  load_and_authorize_resource except: :create

  def index
    @clarifications = Clarification.all
  end

  def new
    @clarification = current_user.clarifications.build
  end

  def create
    @clarification = current_user.clarifications.build(new_clarification_params)
    authorize! :create, @clarification
    if @clarification.save
      PrivatePub.publish_to "/judge/notify", :notification => "New clarification asked"
      redirect_to clarifications_path, notice: "Clarification submitted"
    else
      render :new
    end
  end

  def edit

  end

  def update
    if @clarification.update(update_clarification_params)
      PrivatePub.publish_to "/team/notify", :notification => "Clarification answered!"
      redirect_to clarifications_path, notice: "Question answered"
    else
      render :edit
    end
  end

  def destroy
    @clarification.delete
    redirect_to clarifications_path
  end

  private
  def set_clarification
    @clarification = Clarification.find(params[:id])
  end

  def new_clarification_params
    params.require(:clarification).permit(:question, :problem_id)
  end
  def update_clarification_params
    params.require(:clarification).permit(:answer, :judge_id)
  end
end
