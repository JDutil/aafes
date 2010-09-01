class CreateTransactions < ActiveRecord::Migration
  def self.up
    create_table :transactions do |t|
      t.belongs_to :user
      t.belongs_to :client
      t.string :order_id
      t.string :cc_number
      t.integer :amount
      t.string :auth_code
      t.string :auth_ticket
      t.timestamps
    end
    
    add_index :transactions, :user_id
    add_index :transactions, :client_id
    add_index :transactions, :order_id
  end

  def self.down
    drop_table :transactions
  end
end
