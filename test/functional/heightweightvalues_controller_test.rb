require 'test_helper'

class HeightweightvaluesControllerTest < ActionController::TestCase
  setup do
    @heightweightvalue = heightweightvalues(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:heightweightvalues)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create heightweightvalue" do
    assert_difference('Heightweightvalue.count') do
      post :create, :heightweightvalue => @heightweightvalue.attributes
    end

    assert_redirected_to heightweightvalue_path(assigns(:heightweightvalue))
  end

  test "should show heightweightvalue" do
    get :show, :id => @heightweightvalue.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @heightweightvalue.to_param
    assert_response :success
  end

  test "should update heightweightvalue" do
    put :update, :id => @heightweightvalue.to_param, :heightweightvalue => @heightweightvalue.attributes
    assert_redirected_to heightweightvalue_path(assigns(:heightweightvalue))
  end

  test "should destroy heightweightvalue" do
    assert_difference('Heightweightvalue.count', -1) do
      delete :destroy, :id => @heightweightvalue.to_param
    end

    assert_redirected_to heightweightvalues_path
  end
end
