class CreateBxBlockSessionPatientCoachSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :patient_coach_sessions do |t|
    	t.references :account
    	t.references :patient, foreign_key: {to_table: "accounts"}
    	t.references :coach_session
    	t.date :date
    	t.integer :payment_status
    	t.references :session
      t.timestamps
    end
  end
end
