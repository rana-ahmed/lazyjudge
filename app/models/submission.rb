class Submission < ActiveRecord::Base
  belongs_to :user
  belongs_to :problem

  validates :code, :language, :user, :problem, presence: true
  validates :code, length: {minimum: 40}
  validates :language, inclusion: {in: %w(C CPP)}
  validates :result, inclusion: {in: %w(QU AC WA CE RE TL)}

  enum language: [:C, :CPP]
  enum result: [:QU, :AC, :WA, :CE, :RE, :TL]

  def self.is_problem_solved(submission)
    Submission.where(user_id: submission.user_id, problem_id: submission.problem_id, result: Submission.results[:AC]).take
  end
end
