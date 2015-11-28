class Judging
  def self.judge(submission, result)
    if submission.update(result: result)
      solved = Submission.is_problem_solved(submission)
      Judging.new.calculate_point(submission, solved) if solved
      return true
    else
      return false
    end
  end

  def calculate_point(submission, solved)
    penalty_time = (Submission.where(user_id: submission.user_id, problem_id: submission.problem_id).count - 1) * 20
    point = ((solved.updated_at - Setting.contest_timer_start) / 60).to_i + penalty_time
    solved.update(point: point)
  end
end
