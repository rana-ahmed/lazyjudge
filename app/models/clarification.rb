class Clarification < ActiveRecord::Base
  belongs_to :user
  belongs_to :problem

  validates :problem, :question, presence: true
  validates :question, length: {minimum: 25}
end
