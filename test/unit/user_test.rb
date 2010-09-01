require 'test_helper'

class UserTest < ActiveSupport::TestCase
  context "user" do
    setup do
      without_access_control do 
        @user = Factory(:user)
      end
    end
    should have_many(:clients).through(:client_users)
    should have_many(:client_users).dependent(:destroy)
    should have_many(:roles).dependent(:destroy)
    should have_many(:approvals)
    should have_many(:credits)
    should have_many(:settlements)
  end
end