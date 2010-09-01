class Client < ActiveRecord::Base
  has_many :users, :through => :client_users
  has_many :client_users, :dependent => :destroy
  has_many :transactions, :dependent => :destroy
  validates_presence_of(:name)
  validates_presence_of(:facility_number)
  validates_uniqueness_of(:name)
  validates_uniqueness_of(:facility_number)
end