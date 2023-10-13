class RemoveGenderFromDoctor < ActiveRecord::Migration[7.0]
  def change
  	remove_column :doctors, :gender, :string
  	remove_column :doctors, :phone_number, :bigint
  end
end
