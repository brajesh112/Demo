class CreateBxBlockPatientReports < ActiveRecord::Migration[7.0]
  def change
    create_table :reports do |t|
    	t.references :patient, foreign_key: {to_table: 'accounts'}
      t.timestamps
    end
  end
end
