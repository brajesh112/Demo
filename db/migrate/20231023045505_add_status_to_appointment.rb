class AddStatusToAppointment < ActiveRecord::Migration[7.0]
  def change
  	add_column :appointments, :status, :integer
  end
end
