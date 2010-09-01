class CreateApprovals < ActiveRecord::Migration
  def self.up
    create_table :approvals do |t|
      t.integer :amount
      t.belongs_to :user
      t.belongs_to :transaction
      t.timestamps
    end
    
    add_index :approvals, :user_id
    add_index :approvals, :transaction_id
  end

  def self.down
    drop_table :approvals
  end
end
