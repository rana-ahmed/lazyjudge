class Submission < ActiveRecord::Base
  belongs_to :user
  belongs_to :problem

  validates :code, :language, :user, :problem, presence: true
  validates :code, length: {minimum: 40}
  validates :language, inclusion: {in: %w(C CPP)}
  validates :result, inclusion: {in: %w(QU AC WA CE RE TL)}

  enum language: [:C, :CPP]
  enum result: [:QU, :AC, :WA, :CE, :RE, :TL]
end
