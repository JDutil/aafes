require 'test_helper'

class SettlementsControllerTest < ActionController::TestCase
  setup do
    without_access_control do
      @user = Factory(:user)
      @user.roles << Factory(:admin_role)
      login_as(@user)
    
      @settlement = Factory(:settlement)
    end
  end

  test "should get index" do
    get :index, :client_id => @settlement.transaction.client_id, :transaction_id => @settlement.transaction_id
    assert_response :success
    assert_not_nil assigns(:settlements)
  end

  test "should get new" do
    get :new, :client_id => @settlement.transaction.client_id, :transaction_id => @settlement.transaction_id
    assert_response :success
  end

  test "should create settlement" do
    assert_difference('Settlement.count') do
      post :create, :client_id => @settlement.transaction.client_id, :transaction_id => @settlement.transaction_id, :settlement => @settlement.attributes
    end

    assert_redirected_to client_transaction_settlement_path(assigns(:client), assigns(:transaction), assigns(:settlement))
  end

  test "should show settlement" do
    get :show, :client_id => @settlement.transaction.client_id, :transaction_id => @settlement.transaction_id, :id => @settlement.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :client_id => @settlement.transaction.client_id, :transaction_id => @settlement.transaction_id, :id => @settlement.to_param
    assert_response :success
  end

  test "should update settlement" do
    put :update, :client_id => @settlement.transaction.client_id, :transaction_id => @settlement.transaction_id, :id => @settlement.to_param, :settlement => @settlement.attributes
    assert_redirected_to client_transaction_settlement_path(assigns(:client), assigns(:transaction), assigns(:settlement))
  end

  test "should destroy settlement" do
    assert_difference('Settlement.count', -1) do
      delete :destroy, :client_id => @settlement.transaction.client_id, :transaction_id => @settlement.transaction_id, :id => @settlement.to_param
    end

    assert_redirected_to client_transaction_settlements_path(assigns(:client), assigns(:transaction))
  end
end
