class UserSession < Authlogic::Session::Base
  logout_on_timeout true
  
  # RAILS 3 Bug in current authlogic 2.1.6, and below requires this, should remove once a patched authlogic release is out
  def to_key
     new_record? ? nil : [ self.send(self.class.primary_key) ]
  end
  
end