class AddTimeToDoctor < ActiveRecord::Migration[7.0]
  def change
  	add_column :doctors, :start_time, :string
  	add_column :doctors, :end_time, :string
  end
end
