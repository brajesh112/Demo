class RemoveMedicineRefFromPrescription < ActiveRecord::Migration[7.0]
  def change
  	remove_reference :prescriptions, :medicine
  end
end
