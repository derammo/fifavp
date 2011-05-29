require 'test_helper'

class PositioncoefficientsControllerTest < ActionController::TestCase
  setup do
    @positioncoefficient = positioncoefficients(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:positioncoefficients)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create positioncoefficient" do
    assert_difference('Positioncoefficient.count') do
      post :create, :positioncoefficient => @positioncoefficient.attributes
    end

    assert_redirected_to positioncoefficient_path(assigns(:positioncoefficient))
  end

  test "should show positioncoefficient" do
    get :show, :id => @positioncoefficient.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @positioncoefficient.to_param
    assert_response :success
  end

  test "should update positioncoefficient" do
    put :update, :id => @positioncoefficient.to_param, :positioncoefficient => @positioncoefficient.attributes
    assert_redirected_to positioncoefficient_path(assigns(:positioncoefficient))
  end

  test "should destroy positioncoefficient" do
    assert_difference('Positioncoefficient.count', -1) do
      delete :destroy, :id => @positioncoefficient.to_param
    end

    assert_redirected_to positioncoefficients_path
  end
end
