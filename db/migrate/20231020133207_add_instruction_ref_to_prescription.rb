class AddInstructionRefToPrescription < ActiveRecord::Migration[7.0]
  def change
  	add_reference :prescriptions, :instruction
  end
end
