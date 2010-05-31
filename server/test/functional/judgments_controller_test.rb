require 'test_helper'

class JudgmentsControllerTest < ActionController::TestCase
  setup do
    @judgment = judgments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:judgments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create judgment" do
    assert_difference('Judgment.count') do
      post :create, :judgment => @judgment.attributes
    end

    assert_redirected_to judgment_path(assigns(:judgment))
  end

  test "should show judgment" do
    get :show, :id => @judgment.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @judgment.to_param
    assert_response :success
  end

  test "should update judgment" do
    put :update, :id => @judgment.to_param, :judgment => @judgment.attributes
    assert_redirected_to judgment_path(assigns(:judgment))
  end

  test "should destroy judgment" do
    assert_difference('Judgment.count', -1) do
      delete :destroy, :id => @judgment.to_param
    end

    assert_redirected_to judgments_path
  end
end
