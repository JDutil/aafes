class ClientUser < ActiveRecord::Base
  belongs_to :client
  belongs_to :user
  validates_presence_of :user_id
  validates_presence_of :client_id  
end