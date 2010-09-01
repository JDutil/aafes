class CreateSettlements < ActiveRecord::Migration
  def self.up
    create_table :settlements do |t|
      t.integer :amount
      t.belongs_to :user
      t.belongs_to :transaction
      t.timestamps
    end
    
    add_index :settlements, :user_id
    add_index :settlements, :transaction_id
  end

  def self.down
    drop_table :settlements
  end
end
