ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require "authlogic/test_case" # include at the top of test_helper.rb
require 'declarative_authorization/maintenance'

class ActiveSupport::TestCase
  include Authlogic::TestCase
  include Authorization::TestHelper
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def login_as( user_or_sym )
    activate_authlogic
    
    user = user_or_sym.is_a?(User) ? user_or_sym : users(user_or_sym)
    assert_nil session["user_credentials"]
  
    assert UserSession.create( user )
  
    assert_equal user.persistence_token, session["user_credentials"]
  end
  
  # def current_user_session
  #   return @current_user_session if defined?(@current_user_session)
  #   @current_user_session = UserSession.find
  # end
  # 
  # def current_user
  #   return @current_user if defined?(@current_user)
  #   @current_user = current_user_session && current_user_session.record
  # end
  
end
