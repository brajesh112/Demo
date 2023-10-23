class AddStatusToDoctor < ActiveRecord::Migration[7.0]
  def change
  	add_column :doctors, :status, :integer
  end
end
