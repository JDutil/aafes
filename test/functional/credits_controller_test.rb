require 'test_helper'

class CreditsControllerTest < ActionController::TestCase
  setup do
    without_access_control do
      @user = Factory(:user)
      @user.roles << Factory(:admin_role)
      login_as(@user)
    
      @credit = Factory(:credit)
    end
  end
  
  test "should get index" do
    get :index, :client_id => @credit.transaction.client_id, :transaction_id => @credit.transaction_id
    assert_response :success
    assert_not_nil assigns(:credits)
  end

  test "should get new" do
    get :new, :client_id => @credit.transaction.client_id, :transaction_id => @credit.transaction_id
    assert_response :success
  end

  test "should create credit" do
    assert_difference('Credit.count') do
      post :create, :client_id => @credit.transaction.client_id, :transaction_id => @credit.transaction_id, :credit => @credit.attributes
    end

    assert_redirected_to client_transaction_credit_path(assigns(:client), assigns(:transaction), assigns(:credit))
  end

  test "should show credit" do
    get :show, :client_id => @credit.transaction.client_id, :transaction_id => @credit.transaction_id, :id => @credit.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :client_id => @credit.transaction.client_id, :transaction_id => @credit.transaction_id, :id => @credit.to_param
    assert_response :success
  end

  test "should update credit" do
    put :update, :client_id => @credit.transaction.client_id, :transaction_id => @credit.transaction_id, :id => @credit.to_param, :credit => @credit.attributes
    assert_redirected_to client_transaction_credit_path(assigns(:client), assigns(:transaction), assigns(:credit))
  end

  test "should destroy credit" do
    assert_difference('Credit.count', -1) do
      delete :destroy, :client_id => @credit.transaction.client_id, :transaction_id => @credit.transaction_id, :id => @credit.to_param
    end

    assert_redirected_to client_transaction_credits_path(assigns(:client), assigns(:transaction))
  end
end
