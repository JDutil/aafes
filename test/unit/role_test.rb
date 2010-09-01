require 'test_helper'

class RoleTest < ActiveSupport::TestCase
  context "role" do
    setup do
      without_access_control do 
        @role = Factory(:role)
      end
    end
    should belong_to(:user)
    should validate_presence_of(:user_id)
    should validate_presence_of(:title)
  end
end