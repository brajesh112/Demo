class CreateBxBlockCoachCoaches < ActiveRecord::Migration[7.0]
  def change
    create_table :coaches do |t|
    	t.string :name
    	t.datetime :practicing_from
    	t.bigint :phone_number
    	t.text :professional_statement
    	t.string :gender
    	t.references :account
      t.timestamps
    end
  end
end
