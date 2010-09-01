require 'test_helper'

class ClientUserTest < ActiveSupport::TestCase
  context "client user" do
    setup do
      without_access_control do 
        @client_user = Factory(:client_user)
      end
    end
    should belong_to(:client)
    should belong_to(:user)
    should validate_presence_of(:user_id)
    should validate_presence_of(:client_id)
  end
end