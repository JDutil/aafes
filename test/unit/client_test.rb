require 'test_helper'

class ClientTest < ActiveSupport::TestCase
  context "client" do
    setup do
      without_access_control do 
        @client = Factory(:client)
      end
    end
    should have_many(:users).through(:client_users)
    should have_many(:client_users).dependent(:destroy)
    should have_many(:transactions).dependent(:destroy)
    should validate_presence_of(:name)
    should validate_uniqueness_of(:name)
    should validate_presence_of(:facility_number)
    should validate_uniqueness_of(:facility_number)
  end
end