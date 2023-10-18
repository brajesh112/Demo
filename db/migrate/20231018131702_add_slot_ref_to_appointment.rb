class AddSlotRefToAppointment < ActiveRecord::Migration[7.0]
  def change
  	add_reference :appointments, :slot
  end
end
