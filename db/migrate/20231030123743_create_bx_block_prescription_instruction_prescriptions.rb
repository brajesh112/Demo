class CreateBxBlockPrescriptionInstructionPrescriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :instruction_prescriptions do |t|
    	t.references :medicine
    	t.references :instruction
    	t.references :prescription
      t.timestamps
    end
  end
end
