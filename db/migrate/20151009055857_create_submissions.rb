class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.references :user, index: true
      t.references :problem, index: true
      t.text :code
      t.integer :language
      t.integer :point
      t.integer :result
      t.string :reference

      t.timestamps null: false
    end
    add_foreign_key :submissions, :users
    add_foreign_key :submissions, :problems
  end
end
