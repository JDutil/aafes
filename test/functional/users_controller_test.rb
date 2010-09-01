require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    #without_access_control do
      @user = Factory(:user)
      @user.roles << Factory(:admin_role)
      login_as(@user)
    #end
  end
  
  test "should get index" do
    login_as(Factory(:user))
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    login_as(Factory(:user))
    
    get :new
    assert_response :success
  end

  test "should create user" do
    login_as(Factory(:user))
    
    assert_difference('User.count') do
      post :create, :user => {:email=>"new@test.com", :password=>"testing", :password_confirmation=>"testing"}
    end
    
    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    login_as(Factory(:user))
    
    get :show, :id => @user.to_param
    assert_response :success
  end

  test "should get edit" do
    login_as(Factory(:user))
    
    get :edit, :id => @user.to_param
    assert_response :success
  end

  test "should update user" do
    login_as(Factory(:user))
    
    put :update, :id => @user.to_param, :user => @user.attributes
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    login_as(Factory(:user))
    
    assert_difference('User.count', -1) do
      delete :destroy, :id => @user.to_param
    end
  
    assert_redirected_to users_path
  end
end
