class CreateCoachesSpecialization < ActiveRecord::Migration[7.0]
  def change
    create_table :coaches_specializations do |t|
    	t.references :coach
    	t.references :specialization
      t.timestamps
    end
  end
end
