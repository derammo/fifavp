require 'test_helper'

class HeightweightsControllerTest < ActionController::TestCase
  setup do
    @heightweight = heightweights(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:heightweights)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create heightweight" do
    assert_difference('Heightweight.count') do
      post :create, :heightweight => @heightweight.attributes
    end

    assert_redirected_to heightweight_path(assigns(:heightweight))
  end

  test "should show heightweight" do
    get :show, :id => @heightweight.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @heightweight.to_param
    assert_response :success
  end

  test "should update heightweight" do
    put :update, :id => @heightweight.to_param, :heightweight => @heightweight.attributes
    assert_redirected_to heightweight_path(assigns(:heightweight))
  end

  test "should destroy heightweight" do
    assert_difference('Heightweight.count', -1) do
      delete :destroy, :id => @heightweight.to_param
    end

    assert_redirected_to heightweights_path
  end
end
