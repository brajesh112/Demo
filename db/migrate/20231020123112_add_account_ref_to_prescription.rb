class AddAccountRefToPrescription < ActiveRecord::Migration[7.0]
  def change
  	add_reference :prescriptions, :account
  end
end
