class CreateCredits < ActiveRecord::Migration
  def self.up
    create_table :credits do |t|
      t.integer :amount
      t.belongs_to :user
      t.belongs_to :transaction
      t.timestamps
    end
    
    add_index :credits, :user_id
    add_index :credits, :transaction_id
  end

  def self.down
    drop_table :credits
  end
end
