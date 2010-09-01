class CreateClientUsers < ActiveRecord::Migration
  def self.up
    create_table :client_users do |t|
      t.belongs_to :client
      t.belongs_to :user

      t.timestamps
    end
    
    add_index :client_users, :client_id
    add_index :client_users, :user_id
  end

  def self.down
    drop_table :client_users
  end
end
