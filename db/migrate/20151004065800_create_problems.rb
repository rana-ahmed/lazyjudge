class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      t.string :title
      t.string :time_limit, default: "1s"
      t.string :memory_limit, default: "1024"
      t.text :description
      t.text :input_description, default: "n/a"
      t.text :output_description, default: "n/a"
      t.text :sample_input, default: "n/a"
      t.text :sample_output, default: "n/a"
      t.text :judge_input, default: ""
      t.text :judge_output, default: ""

      t.timestamps null: false
    end
  end
end
