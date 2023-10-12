class CreateBxBlockSpecializationSpecializations < ActiveRecord::Migration[7.0]
  def change
    create_table :specializations do |t|
    	t.string "specialization_name"
      t.timestamps
    end
  end
end
