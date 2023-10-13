class CreateBxBlockPatientPatients < ActiveRecord::Migration[7.0]
  def change
    create_table :patients do |t|
    	t.string :first_name
    	t.string :last_name
    	t.string :email
    	t.bigint :phone_number
    	t.integer :age
    	t.text :address
    	t.string :gender 
    	t.references :account
      t.timestamps
    end
  end
end
