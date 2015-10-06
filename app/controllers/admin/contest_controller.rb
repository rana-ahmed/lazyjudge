class Admin::ContestController < ApplicationController
  before_action :set_info, only: :index
  before_action :validates_setting, only: :setting
  def index

  end

  def setting
    Setting.contest_duration = params[:setting][:duration]
    Setting.contest_c_com = params[:setting][:c_com]
    Setting.contest_cpp_com = params[:setting][:cpp_com]
    redirect_to admin_contest_path
  end

  def contest_start
    if Setting.contest_duration.nil?
      redirect_to :back, notice: "Set contest duration first"
    else
      Setting.contest_timer_start = Time.now
      Setting.contest_timer_stop = Time.now + Setting.contest_duration.to_i.minutes
      redirect_to :back, notice: "Contest successfully started"
    end
  end

  def contest_stop
    Setting.contest_timer_start = nil
    Setting.contest_timer_stop = nil
    redirect_to :back, notice: "Contest successfully stopped"
  end

  private
  def validates_setting
    message = ""
    message += "# Contest duration invalid<br>" if !(params[:setting][:duration] =~ /\A[1-9]\d{0,2}\z/)
    message += "# C compiler url invalid<br>" if !(params[:setting][:c_com] =~ /\A#{URI::regexp(['http', 'https'])}\z/)
    message += "# C++ compiler url invalid<br>" if !(params[:setting][:cpp_com] =~ /\A#{URI::regexp(['http', 'https'])}\z/)
    flash[:setting_error] = message if !message.empty?
    redirect_to :back if !message.empty?
  end

  def set_info
    @user_info = Hash.new
    @user_info[:user_number] = User.count
    @user_info[:admin_number] = User.admin.count
    @user_info[:judge_number] = User.judge.count
    @user_info[:team_number] = User.team.count

    @problem_info = Hash.new
    @problem_info[:problem_number] = Problem.count
    @problem_info[:clarification_number] = Clarification.count
    @problem_info[:submission_number] = "future"
  end
end
