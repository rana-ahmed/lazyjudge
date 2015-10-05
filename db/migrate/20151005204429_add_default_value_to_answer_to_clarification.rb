class AddDefaultValueToAnswerToClarification < ActiveRecord::Migration
  def change
    change_column :clarifications, :answer, :text, :default => "<Not answered, yet>"
  end
end
