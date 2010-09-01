require 'test_helper'

class TransactionsControllerTest < ActionController::TestCase
  setup do
    without_access_control do
      @user = Factory(:user)
      @user.roles << Factory(:admin_role)
      login_as(@user)
    
      @transaction = Factory(:transaction)
    end
  end

  test "should get index" do
    get :index, :client_id => @transaction.client_id
    assert_response :success
    assert_not_nil assigns(:transactions)
  end

  test "should get new" do
    get :new, :client_id => @transaction.client_id
    assert_response :success
  end

  test "should create transaction" do
    assert_difference('Transaction.count') do
      post :create, :client_id => @transaction.client_id, :transaction => @transaction.attributes
    end

    assert_redirected_to client_transaction_path(assigns(:client), assigns(:transaction))
  end

  test "should show transaction" do
    get :show, :client_id => @transaction.client_id, :id => @transaction.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :client_id => @transaction.client_id, :id => @transaction.to_param
    assert_response :success
  end

  test "should update transaction" do
    put :update, :client_id => @transaction.client_id, :id => @transaction.to_param, :transaction => @transaction.attributes
    assert_redirected_to client_transaction_path(assigns(:client), assigns(:transaction))
  end

  test "should destroy transaction" do
    assert_difference('Transaction.count', -1) do
      delete :destroy, :client_id => @transaction.client_id, :id => @transaction.to_param
    end

    assert_redirected_to client_transactions_path(assigns(:client))
  end
end
