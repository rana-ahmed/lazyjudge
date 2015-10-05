class AddJudgeIdToClarifications < ActiveRecord::Migration
  def change
    add_column :clarifications, :judge_id, :integer
  end
end
