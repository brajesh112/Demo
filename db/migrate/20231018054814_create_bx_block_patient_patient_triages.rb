class CreateBxBlockPatientPatientTriages < ActiveRecord::Migration[7.0]
  def change
    create_table :patient_triages do |t|
    	t.references :patient
    	t.string :blood_pressure
    	t.string :sugar_level
    	t.string :blood_group
    	t.string :heart_beat
    	t.string :height
    	t.string :weight
    	t.decimal :fee
      t.timestamps
    end
  end
end
