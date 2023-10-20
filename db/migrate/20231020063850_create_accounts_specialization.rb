class CreateAccountsSpecialization < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts_specializations do |t|
    	t.references :account
    	t.references :specialization
      t.timestamps
    end
  end
end
