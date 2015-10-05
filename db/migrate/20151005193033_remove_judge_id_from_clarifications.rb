class RemoveJudgeIdFromClarifications < ActiveRecord::Migration
  def change
    remove_reference :clarifications, :judge, index: true
    remove_foreign_key :clarifications, :judges
  end
end
