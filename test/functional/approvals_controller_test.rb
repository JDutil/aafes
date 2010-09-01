require 'test_helper'

class ApprovalsControllerTest < ActionController::TestCase
  setup do
    without_access_control do
      @user = Factory(:user)
      @user.roles << Factory(:admin_role)
      login_as(@user)
      @approval = Factory(:approval) 
    end
  end

  test "should get index" do
    get :index, :client_id => @approval.transaction.client_id, :transaction_id => @approval.transaction_id
    assert_response :success
    assert_not_nil assigns(:approvals)
  end

  test "should get new" do
    get :new, :client_id => @approval.transaction.client_id, :transaction_id => @approval.transaction_id
    assert_response :success
  end

  test "should create approval" do
    assert_difference('Approval.count') do
      post :create, :client_id => @approval.transaction.client_id, :transaction_id => @approval.transaction_id, :approval => @approval.attributes
    end

    assert_redirected_to client_transaction_approval_path(assigns(:client), assigns(:transaction), assigns(:approval))
  end

  test "should show approval" do
    get :show, :client_id => @approval.transaction.client_id, :transaction_id => @approval.transaction_id, :id => @approval.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :client_id => @approval.transaction.client_id, :transaction_id => @approval.transaction_id, :id => @approval.to_param
    assert_response :success
  end

  test "should update approval" do
    put :update, :client_id => @approval.transaction.client_id, :transaction_id => @approval.transaction_id, :id => @approval.to_param, :approval => @approval.attributes
    assert_redirected_to client_transaction_approval_path(assigns(:client), assigns(:transaction), assigns(:approval))
  end

  test "should destroy approval" do
    assert_difference('Approval.count', -1) do
      delete :destroy, :client_id => @approval.transaction.client_id, :transaction_id => @approval.transaction_id, :id => @approval.to_param
    end

    assert_redirected_to client_transaction_approvals_path(assigns(:client), assigns(:transaction))
  end
end
