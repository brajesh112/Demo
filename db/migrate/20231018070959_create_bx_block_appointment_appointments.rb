class CreateBxBlockAppointmentAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :appointments do |t|
    	t.references :patient
    	t.references :healthcareable, polymorphic: true
    	t.datetime :date
      t.timestamps
    end
  end
end
