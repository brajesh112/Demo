class AddTimeToCoach < ActiveRecord::Migration[7.0]
  def change
  	add_column :coaches, :start_time, :string
  	add_column :coaches, :end_time, :string
  end
end
