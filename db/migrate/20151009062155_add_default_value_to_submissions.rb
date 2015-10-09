class AddDefaultValueToSubmissions < ActiveRecord::Migration
  def change
    change_column :submissions, :point, :integer, default: 0
    change_column :submissions, :result, :integer, default: 0
  end
end
