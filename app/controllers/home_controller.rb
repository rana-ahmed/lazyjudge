class HomeController < ApplicationController
  def index
    #here we will call current_user_root
  end

  def score_board
    @score = Submission.score_board
  end
end
