class Approval < ActiveRecord::Base
  belongs_to(:user)
  belongs_to :transaction
  validates_presence_of(:user_id)
  validates_presence_of(:transaction_id)
  validates_presence_of(:amount)
  
  using_access_control
  
end