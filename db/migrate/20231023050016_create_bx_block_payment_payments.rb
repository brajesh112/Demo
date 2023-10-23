class CreateBxBlockPaymentPayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
    	t.references :account
    	t.references :patient, foreign_key: {to_table: "accounts"}
    	t.string :payment_id
    	t.decimal :amount
    	t.datetime :date
      t.timestamps
    end
  end
end
