require 'test_helper'

class LogicalFormsControllerTest < ActionController::TestCase
  setup do
    @logical_form = logical_forms(:one)
    @update = {
      :key  => 'test',
      :data => '<xml></xml>',
      :pdf => 'ABCD'
    }
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:logical_forms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create logical_form" do
    assert_difference('LogicalForm.count') do
      post :create, :logical_form => @update
    end

    assert_redirected_to logical_form_path(assigns(:logical_form))
  end

  test "should show logical_form" do
    get :show, :id => @logical_form.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @logical_form.to_param
    assert_response :success
  end

  test "should update logical_form" do
    put :update, :id => @logical_form.to_param, :logical_form => @update
    assert_redirected_to logical_form_path(assigns(:logical_form))
  end

  test "should destroy logical_form" do
    assert_difference('LogicalForm.count', -1) do
      delete :destroy, :id => @logical_form.to_param
    end

    assert_redirected_to logical_forms_path
  end
end
