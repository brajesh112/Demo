class AddOrderToPayment < ActiveRecord::Migration[7.0]
  def change
  	add_column :payments, :order_id, :string
  	add_column :payments, :payment_status, :string
  end
end
