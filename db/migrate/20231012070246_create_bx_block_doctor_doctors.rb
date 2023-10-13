class CreateBxBlockDoctorDoctors < ActiveRecord::Migration[7.0]
  def change
    create_table :doctors do |t|
			t.string :name
    	t.datetime :practicing_from
    	t.text :professional_statement
    	t.string :gender
    	t.bigint :phone_number
    	t.references :account
    	t.references :department
      t.timestamps
    end
  end
end
