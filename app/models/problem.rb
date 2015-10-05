class Problem < ActiveRecord::Base
  has_many :clarifications, dependent: :destroy
  validates :title, :time_limit, :memory_limit,
  :description, :judge_input, :judge_output, presence: true
  validates :memory_limit, numericality: { only_integer: true }
  validates :time_limit, format: { with: /\A\d{1,2}[s]\z/, message: "Formate should be [time][s]" }
end
