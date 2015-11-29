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

  def self.score_board
    query = "SELECT user_name, solved_problem, tried_problem, point
    FROM
    (SELECT
    user_id,
    COUNT(DISTINCT problem_id) AS solved_problem,
    SUM(point) as point
    FROM submissions
    WHERE result = 1
    GROUP BY user_id) A
    INNER JOIN
    (SELECT user_id,
    COUNT(DISTINCT problem_id) AS tried_problem
    FROM submissions
    GROUP BY user_id) B
    ON A.user_id = B.user_id
    INNER JOIN users
    ON A.user_id = users.id
    ORDER BY solved_problem DESC, point ASC"
    ActiveRecord::Base.connection.execute query
  end
end
