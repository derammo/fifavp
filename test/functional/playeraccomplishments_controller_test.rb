require 'test_helper'

class PlayeraccomplishmentsControllerTest < ActionController::TestCase
  setup do
    @playeraccomplishment = playeraccomplishments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:playeraccomplishments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create playeraccomplishment" do
    assert_difference('Playeraccomplishment.count') do
      post :create, :playeraccomplishment => @playeraccomplishment.attributes
    end

    assert_redirected_to playeraccomplishment_path(assigns(:playeraccomplishment))
  end

  test "should show playeraccomplishment" do
    get :show, :id => @playeraccomplishment.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @playeraccomplishment.to_param
    assert_response :success
  end

  test "should update playeraccomplishment" do
    put :update, :id => @playeraccomplishment.to_param, :playeraccomplishment => @playeraccomplishment.attributes
    assert_redirected_to playeraccomplishment_path(assigns(:playeraccomplishment))
  end

  test "should destroy playeraccomplishment" do
    assert_difference('Playeraccomplishment.count', -1) do
      delete :destroy, :id => @playeraccomplishment.to_param
    end

    assert_redirected_to playeraccomplishments_path
  end
end
