class User < ActiveRecord::Base
  acts_as_authentic do |c|
    
  end
  
  using_access_control
  has_many :roles, :dependent => :destroy
  
  def role_symbols
    (roles || []).map {|r| r.title.to_sym}
  end
  
  has_many :approvals
  has_many :credits
  has_many :settlements
  
  has_many :clients, :through => :client_users
  has_many :client_users, :dependent => :destroy
  
  after_create do |user|
    user.roles.create(:title=>"client")
    user.update_attribute(:confirmed_on, DateTime.now)
    user.update_attribute(:confirmed, true)
  end
end