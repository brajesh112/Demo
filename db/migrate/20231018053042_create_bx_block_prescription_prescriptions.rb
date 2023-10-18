class CreateBxBlockPrescriptionPrescriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :prescriptions do |t|
    	t.string :duration
    	t.integer :quantity
    	t.references :medicine
    	t.references :patient
      t.timestamps
    end
  end
end
