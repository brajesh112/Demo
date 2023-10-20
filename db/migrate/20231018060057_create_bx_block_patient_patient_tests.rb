class CreateBxBlockPatientPatientTests < ActiveRecord::Migration[7.0]
  def change
    create_table :patient_tests do |t|
    	t.references :patient, foreign_key: {to_table: 'accounts'}
    	t.string :test_name
    	t.string :organization
    	t.datetime :date
    	t.decimal :fee
    	t.text :description
    	t.references :account
    	t.string :lab_assistent
      t.integer :status
      t.references :report
      t.timestamps
    end
  end
end
