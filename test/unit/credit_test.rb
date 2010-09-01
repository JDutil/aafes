require 'test_helper'

class CreditTest < ActiveSupport::TestCase
  context "credit" do
    setup do
      without_access_control do 
        @credit = Factory(:credit)
      end
    end
    should belong_to(:user)
    should belong_to(:transaction)
    should validate_presence_of(:user_id)
    should validate_presence_of(:transaction_id)
    should validate_presence_of(:amount)
  end
end