class Admin::ContestController < ApplicationController
  def index
    @user_info = Hash.new
    @user_info[:user_number] = User.count
    @user_info[:admin_number] = User.admin.count
    @user_info[:judge_number] = User.judge.count
    @user_info[:team_number] = User.team.count

    @problem_info = Hash.new
    @problem_info[:problem_number] = Problem.count
    @problem_info[:clarification_number] = Clarification.count
    @problem_info[:submission_number] = "future"

    @settings_info = Hash.new
    @settings_info[:duration] = "future"
    @settings_info[:c_com] = "future"
    @settings_info[:cpp_com] = "future"
  end
end
