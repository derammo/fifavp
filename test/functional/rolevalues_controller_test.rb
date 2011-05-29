require 'test_helper'

class RolevaluesControllerTest < ActionController::TestCase
  setup do
    @rolevalue = rolevalues(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rolevalues)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rolevalue" do
    assert_difference('Rolevalue.count') do
      post :create, :rolevalue => @rolevalue.attributes
    end

    assert_redirected_to rolevalue_path(assigns(:rolevalue))
  end

  test "should show rolevalue" do
    get :show, :id => @rolevalue.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @rolevalue.to_param
    assert_response :success
  end

  test "should update rolevalue" do
    put :update, :id => @rolevalue.to_param, :rolevalue => @rolevalue.attributes
    assert_redirected_to rolevalue_path(assigns(:rolevalue))
  end

  test "should destroy rolevalue" do
    assert_difference('Rolevalue.count', -1) do
      delete :destroy, :id => @rolevalue.to_param
    end

    assert_redirected_to rolevalues_path
  end
end
