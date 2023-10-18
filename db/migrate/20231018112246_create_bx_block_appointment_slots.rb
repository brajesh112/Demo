class CreateBxBlockAppointmentSlots < ActiveRecord::Migration[7.0]
  def change
    create_table :slots do |t|
    	t.string :slot_time
      t.timestamps
    end
  end
end
