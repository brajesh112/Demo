class CreateDoctorsSpecialization < ActiveRecord::Migration[7.0]
  def change
    create_table :doctors_specializations do |t|
    	t.references :doctor
    	t.references :specialization
      t.timestamps
    end
  end
end
