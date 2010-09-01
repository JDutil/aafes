class CreateClients < ActiveRecord::Migration
  def self.up
    create_table :clients do |t|
      t.integer :facility_number
      t.string :name
      t.timestamps
    end
    
    add_index :clients, :facility_number
  end

  def self.down
    drop_table :clients
  end
end
