class CreateBxBlockConversationConversations < ActiveRecord::Migration[7.0]
  def change
    create_table :conversations do |t|
      t.string :conversation_id
      t.references :account
      t.references :patient, foreign_key: {to_table: "accounts"}
      t.timestamps
    end
  end
end
