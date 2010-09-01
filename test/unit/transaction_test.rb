require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  context "transaction" do
    setup do
      without_access_control do 
        @transaction = Factory(:transaction)
      end
    end
    should belong_to(:user)
    should belong_to(:client)
    should validate_presence_of(:user_id)
    should validate_presence_of(:client_id)
    should validate_presence_of(:cc_number)
    should validate_presence_of(:amount)
    should validate_presence_of(:auth_code)
    should validate_presence_of(:auth_ticket)
    #should validate_presence_of(:order_id)
    should have_many(:approvals).dependent(:destroy)
    should have_many(:credits).dependent(:destroy)
    should have_many(:settlements).dependent(:destroy)
  end
end