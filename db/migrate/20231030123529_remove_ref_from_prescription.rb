class RemoveRefFromPrescription < ActiveRecord::Migration[7.0]
  def change
  	remove_reference :prescriptions, :instruction
  end
end
