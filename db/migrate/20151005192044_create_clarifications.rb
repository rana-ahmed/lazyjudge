class CreateClarifications < ActiveRecord::Migration
  def change
    create_table :clarifications do |t|
      t.text :question
      t.text :answer
      t.references :user, index: true
      t.references :judge, index: true
      t.references :problem, index: true

      t.timestamps null: false
    end
    add_foreign_key :clarifications, :users
    add_foreign_key :clarifications, :judges
    add_foreign_key :clarifications, :problems
  end
end
