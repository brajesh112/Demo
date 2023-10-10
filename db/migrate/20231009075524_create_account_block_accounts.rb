class CreateAccountBlockAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
    	t.string :email
    	t.string :first_name
    	t.string :last_name
    	t.string :user_name
    	t.string :gender
    	t.string :password_digest
      t.timestamps
    end
  end
end
