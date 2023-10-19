class CreateBxBlockAppointmentAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :appointments do |t|
    	t.references :patient, foreign_key: {to_table: 'accounts'}
    	t.string :healtcareable_type
    	t.references :slot
    	t.references :account, foreign_key: :healtcareable_id
    	t.datetime :date
      t.timestamps
    end
  end
end
